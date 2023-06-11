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
      expect(assigns(:openings)).to eq [o1]
    end
  end
end
