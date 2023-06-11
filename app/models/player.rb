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
end
