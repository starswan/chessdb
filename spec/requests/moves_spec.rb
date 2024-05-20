require 'rails_helper'

RSpec.describe "Moves", type: :request do
  let(:game) { create(:game) }

  before do
    game.create_moves!
    get game_moves_path(game, format: :json)
  end

  it "has a good status" do
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body, symbolize_names: true).first(2))
      .to eq(
        [
          { fen: "rnbqkbnr/pppppppp/8/8/8/2N5/PPPPPPPP/R1BQKBNR b KQkq - 1 1", from: "b1", move: "Nc3", number: 0, piece: "N", to: "c3" },
          { fen: "rnbqkbnr/ppp1pppp/8/3p4/8/2N5/PPPPPPPP/R1BQKBNR w KQkq d6 0 2", from: "d7", move: "d5", number: 1, piece: "p", to: "d5" },
        ],
      )
  end
end
