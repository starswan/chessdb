# frozen_string_literal: true
#
# $Id$
#
class PgnImportJob < ApplicationJob
  queue_priority 10

  FOREIGN_WORDS = ['Chess960', '+[Result "0-1"]', '} 0-1', '} 1-0', 'SetUp'].freeze
  # FOREIGN_WORDS = ['Sparkasse', 'Strelec', 'Chess960', 'Schachgesellschaft',
  #                  'Echecs', 'Sachy', 'Samara', 'Novy', 'GRACIENCA', 'LIMMONT',
  #                  'VUKOVAR', 'SK Dama', 'BARCELONISTA', 'MISLATA', 'Glek']
  REPLACEMENTS = {
    "- \n" => "\n",
    '00-1' => '0-1',
    "-\n" => "\n",
    '2014.10."' => '2014.10.01"',
  }.freeze

  def perform(comment, game_text)
    # disable the query cache, otherwise it is liable to grow w/o bound
    # maybe this is a bad idea?
    # ActiveRecord::Base.connection.disable_query_cache!
    if FOREIGN_WORDS.any? { |word| game_text.include?(word) }
      logger.warn('Probably Chess960 Game')
    else
      import(comment, game_text)
    end
  end

  PGNStruct = Struct.new :header, :moves, :raw_pgn, keyword_init: true

  def import(comment, game_text)
    game = game_text.dup
    REPLACEMENTS.each do |k, v|
      game.gsub!(k, v)
    end
    game_lines = game.split("\n")
    # ply_count = game_lines.detect { |l| l.starts_with?('[PlyCount') }&.split('"')&.second
    # return if ply_count.present? && ply_count.to_i < 20
    date = game_lines.detect { |l| l.starts_with?('[Date') }&.split('"')&.second
    if game.include?('.??')
      game.gsub!('.??', '.01')
    end
    source_date = game_lines.detect { |l| l.starts_with?('[SourceDate') }&.split('"')&.second
    if source_date
      trydate = Date.parse(date) rescue nil
      game.gsub!(date, source_date) unless trydate
    end
    # Now using Bchess PGN parser - hopefully it copes with Annotated games, or can be enhanced to cope with them
    # return if game_lines.detect { |l| l.starts_with? '[Annotator' }
    #
    pgn_games = Bchess::PGN::Parser.new(game).parse.map do |g|
      pgn_game = Bchess::PGN::Game.new(g).tap { |g| g.convert_body_to_moves }
      PGNStruct.new header: pgn_game.header, moves: pgn_game.moves, raw_pgn: g.input
    end
    pgn_games.each do |pgn|
      # return unless [:player_white, :player_black, :elo_white, :elo_black, :eco].all? { |tag| pgn.header.public_send(tag).present? }
      return unless [:player_white, :player_black, :eco].all? { |tag| pgn.header.public_send(tag).present? }

      # logger.warn("White/Black/ECO missing") && return unless [:White, :Black, :ECO].all? { |tag| pgn.tags.has_key?(tag) }
      Game.transaction do
        logger.info "#{comment} #{pgn.header.player_white} vs #{pgn.header.player_black}"
        tags = {
          White: pgn.header.player_white, Black: pgn.header.player_black,
          WhiteElo: pgn.header.elo_white, BlackElo: pgn.header.elo_black,
          ECO: pgn.header.eco,
          Opening: pgn.header.opening,
          Variation: pgn.header.variation.present? ? pgn.header.variation[0].capitalize +  pgn.header.variation[1..]: nil,
          Date: pgn.header.date, Site: pgn.header.site
        }
        if Game.find_from_tags(tags, pgn.raw_pgn).blank?
          db_game = Game.from_tags_and_moves(tags, pgn.moves, pgn.raw_pgn).tap { |game| game.assign_attributes(result: pgn.header.result, pgn: pgn.raw_pgn) }
          if db_game.save
            p1 = "#{db_game.white.last_name},#{db_game.white.first_name}"
            p2 = "#{db_game.black.last_name},#{db_game.black.first_name}"
            opening = "#{db_game.opening.name}/#{db_game.opening.variation}(#{db_game.opening.ecocode})"
            logger.info "Game saved #{comment} #{db_game.date.to_s(:rfc822)} [#{p1}] vs [#{p2}] #{opening} [#{db_game.result}]"
          else
            logger.info "Game errors #{db_game.errors.full_messages}"
          end
        end
      end
    end
  end
end
