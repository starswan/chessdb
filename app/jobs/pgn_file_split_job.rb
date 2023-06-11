# frozen_string_literal: true
#
# $Id$
#
class PgnFileSplitJob < ApplicationJob
  # lower priority than the imports themselves
  queue_priority 30

  FILE_SLICE_SIZE = 5_000

  def perform(filename, delete_flag)
    game_count = File.open(filename, 'r', encoding: 'ISO-8859-15') do |file|
      PgnFileImportJob::PgnReader.new(file.each_line.lazy, logger).count
    end
    (0..(game_count / FILE_SLICE_SIZE)).reverse_each do |game_index|
      start = game_index * FILE_SLICE_SIZE
      PgnFileImportJob.perform_later filename, delete_flag && start == 0, start, start + FILE_SLICE_SIZE, game_count
    end
  end
end
