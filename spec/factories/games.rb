# frozen_string_literal: true
#
# $Id$
#
FactoryBot.define do
  factory :player do
    first_name { 'Fred' }
    last_name { 'Bloggs' }
  end

  factory :opening, class: ChessOpening do
    sequence(:ecocode) do |n|
      letter = 'ABCDE'[n / 100]
      "#{letter}%02d" % ( n % 100)
    end
    name { 'Anything you like' }
  end

  factory :game do
    association :opening
    white { build(:player) }
    black { build(:player) }
    white_elo { 1900 }
    black_elo { 1900 }
    date { Date.today }
    result { '1-0' }
    pgn { 'e4e5' }
    number_of_moves { 20 }
    site { 'Somewhere' }
  end

  factory :move do
    number  { 1 }
    move { 'e4' }
    from { 'e2' }
    to { 'e4' }
    piece { 'P' }
    fen { '8/8/8/8/8/8/8/8' }
  end
end
