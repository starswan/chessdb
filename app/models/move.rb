#
# $Id$
#
class Move < ApplicationRecord
  belongs_to :game

  validates :piece, inclusion: { in: 'KQBNRPkqbnrp'.each_char.to_a, nil: false }
  validates :fen, presence: true

  def white?
    number % 2 == 0
  end
end
