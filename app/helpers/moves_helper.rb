# frozen_string_literal: true
#
# $Id$
#
module MovesHelper
  EIGHT_BLANKS = ' ' * 8
  PIECE_ROW = 'rnbqkbnr'
  PAWN_ROW = 'pppppppp'
  START_POSITION = [
    PIECE_ROW,
    PAWN_ROW,
    EIGHT_BLANKS,
    EIGHT_BLANKS,
    EIGHT_BLANKS,
    EIGHT_BLANKS,
    PAWN_ROW.each_char.map(&:upcase).join,
    PIECE_ROW.each_char.map(&:upcase).join,
  ]

  CASTLING_MOVES = { 'e1g1' => ['h1','f1'].freeze,
                     'e1c1' => ['a1','d1'].freeze,
                     'e8g8' => ['h8','f8'].freeze,
                     'e8c8' => ['a8','d8'].freeze }.freeze
  # convert square into a board position reading downwards. h1 = [0, 0], h8 = [0, 7], a1 = [7, 0], a8 = [7, 7]
  def square_to_pos square
    column = 'abcdefgh'.index(square[0])
    row = 8 - square[1].to_i
    [row, column]
  end

  def position_for(moves)
    position = START_POSITION.map(&:dup)

    moves.each do |move|
      perform_move(position, move.from, move.to)
      if move.piece == 'K' || move.piece == 'k'
        castling = CASTLING_MOVES["#{move.from}#{move.to}"]
        if castling
          perform_move(position, castling[0], castling[1])
        end
      end
    end

    position
  end

  def perform_move(position, move_from, move_to)
    from = square_to_pos(move_from)
    to = square_to_pos(move_to)
    piece = position[from[0]][from[1]]
    position[from[0]][from[1]] = ' '
    position[to[0]][to[1]] = piece
  end

  def display_move_number move
    1 + move.number / 2
  end
end
