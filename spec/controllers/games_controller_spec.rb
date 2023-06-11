# frozen_string_literal: true
#
# $Id$
#
require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:opening) { create(:opening) }
  let!(:chessgame) { create(:game, opening: opening) }

  it "gets index" do
    get :index, params: { opening_id: opening }
    expect(response).to be_successful
    expect(assigns(:games)).not_to be_nil
  end

  it "gets new" do
    get :new, params: { opening_id: opening }
    expect(response).to be_successful
  end

  it "creates game" do
    expect {
      post :create,
           params: {
             opening_id: opening,
             game: {
               black_id: chessgame.black,
               white_elo: 2400,
               black_elo: 2200,
               pgn: 'e2e4',
               number_of_moves: 32,
               date: chessgame.date,
               site: 'blah',
               result: chessgame.result,
               white_id: chessgame.white
             }
           }
    }.to change(Game, :count).by(1)

    assert_redirected_to game_path(assigns(:game))
  end

  context do
    render_views

    it "shows game" do
      get :show, params: { id: chessgame }
      expect(response).to be_successful
    end
  end

  it "gets edit" do
    get :edit, params: { id: chessgame }
    expect(response).to be_successful
  end

  it "updates game" do
    patch :update, params: { id: chessgame, game: { black_id: chessgame.black, date: chessgame.date, result: chessgame.result, white_id: chessgame.white } }
    assert_redirected_to game_path(assigns(:game))
  end

  it "destroys game" do
    expect {
      delete :destroy, params: { id: chessgame }
    }.to change(Game, :count).by(-1)

    assert_redirected_to opening_games_path(opening)
  end
end
