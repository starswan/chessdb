# frozen_string_literal: true
#
# $Id$
#
require 'rails_helper'

RSpec.describe ChessOpening, type: :model do
  let!(:opening) { create(:opening, games: [build(:game)]) }

  it 'destroys child games when destroyed' do
    expect {
      opening.destroy
    }.to change(Game, :count).by(-1)
  end
end
