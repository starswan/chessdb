# frozen_string_literal: true
#
# $Id$
#
require 'rails_helper'

RSpec.describe Players::GamesController, type: :controller do
  describe '#index' do
    let(:player1) { create(:player) }
    let(:player2) { create(:player) }
    let(:player3) { create(:player) }

    before do
      create(:game, white: player1, black: player2)
      create(:game, white: player3, black: player1)
      create(:game, white: player3, black: player2)
    end
    let(:game1) { Game.find_by(white: player1, black: player2) }
    let(:game2) { Game.find_by(white: player3, black: player1) }

    it 'returns all games for the player' do
      get :index, params: { player_id: player1 }
      expect(assigns(:games)).to eq([game1, game2])
    end
  end
end
