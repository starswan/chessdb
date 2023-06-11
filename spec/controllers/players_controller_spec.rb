# frozen_string_literal: true
#
# $Id$
#
require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  let!(:chessplayer) { create(:player) }

  it "gets index" do
    get :index
    expect(response).to be_successful
    expect(assigns(:players)).not_to be_nil
  end

  it "gets new" do
    get :new
    expect(response).to be_successful
  end

  it "creates player" do
    expect {
      post :create, params: { player: { fideid: chessplayer.fideid, first_name: chessplayer.first_name, last_name: chessplayer.last_name } }
    }.to change(Player, :count).by(1)

    assert_redirected_to player_path(assigns(:player))
  end

  it "shows player" do
    get :show, params: { id: chessplayer }
    expect(response).to be_successful
  end

  it "gets edit" do
    get :edit, params: { id: chessplayer }
    expect(response).to be_successful
  end

  it "updates player" do
    patch :update, params: { id: chessplayer, player: { fideid: chessplayer.fideid, first_name: chessplayer.first_name, last_name: chessplayer.last_name } }
    assert_redirected_to player_path(assigns(:player))
  end

  it "destroys player" do
    expect {
      delete :destroy, params: { id: chessplayer }
    }.to change(Player, :count).by(-1)

    assert_redirected_to players_path
  end
end
