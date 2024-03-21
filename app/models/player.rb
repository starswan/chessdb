# frozen_string_literal: true
#
# $Id$
#
class Player < ApplicationRecord
  has_many :white_games, class_name: 'Game', foreign_key: :white_id
  has_many :black_games, class_name: 'Game', foreign_key: :black_id

  validates_presence_of :last_name

  auto_strip_attributes :first_name, :last_name

  # this pattern lets us put a counter cache in with no change to clients
  delegate :count, to: :white_games, prefix: true
  delegate :count, to: :black_games, prefix: true

  class << self
    def find_player(name, fide_id)
      if name.include?(',')
        last, first = name.split(',').map(&:strip)
      elsif name.include?(' ')
        first, last = name.split(' ').map(&:strip)
      else
        first, last = nil, name
      end
      Player.find_or_initialize_by(first_name: first, last_name: last) do |p|
        p.fideid = fide_id
      end
    end
  end
end
