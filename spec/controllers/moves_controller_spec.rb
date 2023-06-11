# frozen_string_literal: true
#
# $Id$
#
require 'rails_helper'

RSpec.describe MovesController, type: :controller do
  let(:opening) { create(:opening) }
  let(:game) { create(:game, opening: opening) }
  let(:chessmove) { game.moves.find_by!(number: 0) }
  let(:blackmove) { game.moves.find_by!(number: 1) }
  let(:move2) { game.moves.find_by!(number: 2) }

  before do
    0.upto(game.number_of_moves - 1).each do |index|
      create(:move, game: game, number: index * 2)
      create(:move, game: game, number: index * 2 + 1)
    end
  end

  it "gets index" do
    get :index, params: { game_id: game }
    expect(response).to be_successful
    expect(assigns(:moves).size).to eq(40)
  end

  it "gets new" do
    get :new, params: { game_id: chessmove.game }
    expect(response).to be_successful
  end

  it "creates move" do
    expect {
      post :create, params: { game_id: chessmove.game, move: { number: chessmove.number, move: chessmove.move,
                            from: chessmove.from, to: 'e4', piece: 'P', fen: chessmove.fen } }
    }.to change(Move, :count).by(1)

    assert_redirected_to move_path(assigns(:move))
  end

  it "shows move" do
    get :show, params: { id: chessmove }
    expect(response).to be_successful
  end

  it "gets edit" do
    get :edit, params: { id: chessmove }
    expect(response).to be_successful
  end

  it "updates move" do
    patch :update, params: { id: chessmove, move: { game_id: chessmove.game_id, number: chessmove.number, move: chessmove.move } }
    assert_redirected_to move_path(assigns(:move))
  end

  it "destroys move" do
    expect {
      delete :destroy, params: { id: chessmove }
    }.to change(Move, :count).by(-1)

    assert_redirected_to moves_path
  end
end
