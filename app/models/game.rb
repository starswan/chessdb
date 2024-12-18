# frozen_string_literal: true
#
# $Id$
#
class Game < ApplicationRecord
  DRAW_RESULT = '1/2-1/2'
  WHITE_RESULT = '1-0'
  BLACK_RESULT = '0-1'

  MAX_GRADING_GAP = 900
  # For now, limit the database to games with a sensible move limit. That way the 'pgn' column doesn't have to be to big
  # MAX_GAME_LENGTH = 120
  # Both players need to be at least as strong as me otherwise they might just be producing garbage
  # would be useful to understand non-played moves though...?
  MIN_GRADE = 1100

  # don't store quick draws - GMs (and IMs) have a habit of 'agreeing' quick draws
  MIN_DRAWN_GAME_LENGTH = 15

  has_many :moves, inverse_of: :game, dependent: :destroy
  belongs_to :white, class_name: 'Player', foreign_key: :white_id, counter_cache: :white_games_count
  belongs_to :black, class_name: 'Player', foreign_key: :black_id, counter_cache: :black_games_count
  belongs_to :opening, class_name: 'ChessOpening', required: true, counter_cache: true

  scope :by_player, ->(player) {
    white = where(white: player)
    black = where(black: player)
    white.or(black)
  }

  scope :by_opening, ->(opening) { where(opening: opening) }

  validates :result, inclusion: { in: [WHITE_RESULT, BLACK_RESULT, DRAW_RESULT], allow_nil: false }
  # don't import 'silly' games with hardly any moves as they won't be instructive
  # maybe non-drawn games can be any length, as we've removed the mismatches
  # validates_numericality_of :number_of_moves, greater_than_or_equal_to: 15, less_than_or_equal_to: MAX_GAME_LENGTH, unless: ->(x) { x.result == DRAW_RESULT }
  # validates_numericality_of :number_of_moves, only_integer: true, less_than_or_equal_to: MAX_GAME_LENGTH
  validates_numericality_of :number_of_moves, only_integer: true
  validates_numericality_of :number_of_moves, greater_than_or_equal_to: MIN_DRAWN_GAME_LENGTH, if: ->(x) { x.result == DRAW_RESULT }

  validates_numericality_of :white_elo, only_integer: true, greater_than_or_equal_to: MIN_GRADE, if: -> { white_elo > 0 }
  validates_numericality_of :black_elo, only_integer: true, greater_than_or_equal_to: MIN_GRADE, if: -> { black_elo > 0 }
  validates_presence_of :opening, :site, :pgn
  # validate the PGN length to prevent overflow rather than limiting the move count
  validates_length_of :pgn, maximum: 2048

  before_validation do
    # try to convert BCF grades to ELO if typed by mistake
    if black_elo < 300 && black_elo > 0
      self.black_elo = 600 + black_elo * 8
    end
    if white_elo < 300 && white_elo > 0
      self.white_elo = 600 + white_elo * 8
    end
  end

  # I'm not sure whether this is actually working...
  # :nocov:
  validate do
    if white_elo - black_elo > MAX_GRADING_GAP && result == WHITE_RESULT && black_elo > 0
      errors.add(:black_elo, "White win - Grading mismatch #{white_elo} vs #{black_elo}")
    end
    if black_elo - white_elo > MAX_GRADING_GAP && result == BLACK_RESULT && white_elo > 0
      errors.add(:white_elo, "Black win - Grading mismatch #{black_elo} vs #{white_elo}")
    end
  end
  # :nocov:

  def self.find_from_tags tags, raw_pgn
    white = Player.find_player(tags.fetch(:White), tags[:WhiteFideId])
    black = Player.find_player(tags.fetch(:Black), tags[:BlackFideId])
    opening = ChessOpening.find_opening(tags.fetch(:ECO), tags.fetch(:Opening), tags.fetch(:Variation), raw_pgn)
    date = Date.parse(tags.fetch(:Date))

    Game.find_by white: white, black: black, opening: opening, date: date
  end

  def self.from_tags_and_moves tags, moves, raw_pgn
    white = Player.find_player(tags.fetch(:White), tags[:WhiteFideId])
    black = Player.find_player(tags.fetch(:Black), tags[:BlackFideId])

    opening = ChessOpening.find_opening(tags.fetch(:ECO), tags.fetch(:Opening), tags.fetch(:Variation), raw_pgn)
    white_elo = tags.fetch(:WhiteElo, 0).to_i
    black_elo = tags.fetch(:BlackElo, 0).to_i
    Game.new white: white,
             black: black,
             opening: opening,
             date: Date.parse(tags.fetch(:Date)),
             white_elo: white_elo,
             black_elo: black_elo,
             site: tags[:Site],
             number_of_moves: (moves.size + 1) / 2
  end

  # FenPieceIndex = Struct.new :fen, :piece, :index, keyword_init: true

  def create_moves!
    parser = Bchess::PGN::Parser.new(pgn)
    first_game = parser.parse.first
    parsed_game = Bchess::PGN::Game.new(first_game)
    parsed_game.convert_body_to_moves

    board = Bchess::Board.new
    board.read_fen
    parsed_game.moves.each_with_index do |move, index|
      old_piece = move.fetch(:piece)
      old_fen = board.fen
      board_piece = board.at(old_piece.column, old_piece.row)
      raise "Failed move #{move}" unless board.move(board_piece, move.fetch(:column), move.fetch(:row), move.fetch(:promoted_piece))
      # FenPieceIndex.new(old_fen: old_fen, fen: board.fen, piece: board_piece, index: index)
      moves.create! move_from_positions(old_fen, board.fen).merge(move: board_piece.to_s, number: index, fen: board.fen)
    end
  end

private

  def move_from_positions old_pos, new_pos
    old = old_pos.split(' ').first.split('/')
    # move_fen = new_pos.split(' ').first
    fen = new_pos.split(' ').first.split('/')

    # [[5, "        ", "    P   "], [7, "PPPPPPPP", "PPPP PPP"]]
    diffs = old.zip(fen).map.with_index { |zz, index| [8 - index, zz.first, zz.last] }
               .select { |fen| fen[1] != fen[2] }
               .map { |f| [f[0], self.class.expand_fen(f[1]), self.class.expand_fen(f[2])] }

    if diffs.size == 1
      src_row, src_from, src_to = diffs.first
      dest_row = src_row

      src_things = src_from.zip(src_to).map.with_index { |ss, index| [index, ss.first, ss.last] }.select { |src| src[1] != src[2] }
      if src_things.size == 2
        src_col, _, _ = src_things.detect { |_ind, _src, dest| dest == ' ' }
        dest_col, _, piece = src_things.detect { |_ind, _src, dest| dest != ' ' }
      else
        src_col, _, _ = src_things.detect { |_col, src_piece, _dest_piece| src_piece.casecmp('K').zero? }
        dest_col, _, piece = src_things.detect { |_col, _src_piece, dest_piece| dest_piece.casecmp('K').zero? }
      end
    else
      src_row, src_from, src_to = diffs.detect { |_row, from, to|  self.class.count_non_spaces(from) > self.class.count_non_spaces(to) }
      dest_row, dest_from, dest_to = diffs.detect { |row, _from, _to| row != src_row }

      src_col, _, _ = src_from.zip(src_to).map.with_index { |ss, index| [index, ss.first, ss.last] }.detect { |src| src[1] != src[2] }
      dest_col, _, piece = dest_from.zip(dest_to).map.with_index { |ss, index| [index, ss.first, ss.last] }.detect { |src| src[1] != src[2] }
    end
    logger.error "Old fen #{old} move_fen #{fen}" if src_col.nil? || dest_col.nil?
    from = 'abcdefgh'[src_col] + src_row.to_s
    to = 'abcdefgh'[dest_col] + dest_row.to_s

    {
      from: from,
      to: to,
      piece: piece
    }
  end

  def self.count_non_spaces line
    line.count { |c| c != ' ' }
  end

  def self.expand_fen fen_line
    fen_line.each_char.map { |c| c.to_i > 0 ? (' ' * c.to_i) : c }.join.each_char.to_a
  end

end
