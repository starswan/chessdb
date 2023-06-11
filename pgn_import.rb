#!/usr/bin/env rails r
# frozen_string_literal: true
#
# $Id$
#
# rails runner script for importing PGN files
#
args = ARGV.dup
delete_file_after = false
if args[0] && args[0] == '-d'
  delete_file_after = true
  args.shift
end

if args.empty?
  pgn_dir = File.join(ENV['HOME'], 'archive', 'Chess', 'Twic')
else
  pgn_dir = args[0]
end

Dir.entries(pgn_dir).select { |k| k.ends_with? '.pgn' }.each do |f|
  PgnFileSplitJob.perform_later(File.join(pgn_dir, f), delete_file_after)
end
