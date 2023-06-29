# frozen_string_literal: true
#
# $Id$
#
class PgnFileImportJob < ApplicationJob
  # lower priority than the imports themselves
  queue_priority 20

  class PgnReader
    BAD_STRINGS = ['* *','+/- +/-', 'ff', '-/+ -/+', '+[Result "0-1"]', 'Chess960', 'SetUp'].freeze
    include Enumerable

    def initialize(file, logger)
      @file = file
      @logger = logger
    end

    def each
      game_lines = []
      in_game = false
      @file.map { |l| l.chomp }.each_with_index do |line, index|
        # @logger.info("#{index}: Line ->#{line}<-") if index % 100000 == 0
        if line.starts_with?('[') && line.ends_with?(']')
          if in_game
            # This is the start of a new game - yield the one we have found so far
            unless BAD_STRINGS.any? { |s| game_lines.include?(s) }
              yield game_lines
            end
            game_lines = []
            in_game = false
          end
        else
          in_game = true
        end
        #TODO: filter out event for now as they often contain unicode data
        # can be fixed by reading zipfile directly
        game_lines << line unless line.include?('[Event') || line.include?('Team')

        # game_lines << line
      end
      unless game_lines.empty?
        unless BAD_STRINGS.any? { |s| game_lines.include?(s) }
          yield game_lines
        end
      end
    end
  end

  def perform(filename, delete_flag, start, finish, total)
    File.open(filename, 'r', encoding: 'ISO-8859-15') do |file|
      games = PgnReader.new(file.each_line.lazy, logger)

      games.each_with_index do |game_lines, index|
        if start <= index && index < finish && index < total
          if [finish, total].min == total
            PgnImportJob.perform_later("#{File.basename(filename,'.pgn')} #{index}/#{total}", game_lines.join("\n"))
          else
            PgnImportJob.perform_later("#{File.basename(filename,'.pgn')} #{start}/#{index}/#{[finish, total].min}/#{total}", game_lines.join("\n"))
          end
        end
      end
    end
    File.unlink(filename) if delete_flag
  end
end
