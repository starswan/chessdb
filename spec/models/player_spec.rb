# frozen_string_literal: true
#
# $Id$
#
require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:wp) { create(:player) }
  let(:bp) { create(:player) }
  let(:game) { Game.first }

  before do
    create(:game, white: wp, black: bp)
  end

  it 'could have white games' do
    expect(wp.white_games).to eq([game])
  end

  it 'could have black games' do
    expect(bp.black_games).to eq([game])
  end
end
