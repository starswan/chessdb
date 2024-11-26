# frozen_string_literal: true
#
# $Id$
#
require 'rails_helper'

RSpec.describe OpeningsController, type: :controller do
  describe '#index' do
    before do
      o1 = create(:opening)
      create(:opening)
      create(:game, opening: o1)
    end
    let(:o1) { ChessOpening.first }

    it 'gets openings with games' do
      get :index
      expect(assigns(:openings)).to eq({o1.name => [o1]})
    end

    it 'gets openings with offset games' do
      get :index, params: { page: 'A' }
      expect(assigns(:openings)).to eq({o1.name => [o1]})
    end
  end

  describe '#destroy' do
    before do
      create(:opening)
    end
    let(:opening) { ChessOpening.last }

    it 'destroys opening' do
      post :destroy, params: { id: opening.id }
      expect(ChessOpening.count).to eq(0)
    end
  end
end
