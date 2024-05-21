require "rails_helper"

RSpec.describe "showing a game", :js, type: :feature do
  let(:game) { Game.last }
  let(:filename) { Rails.root.join('spec', 'files', '231059_1_4.pgn').to_s }

  before do
    PgnFileImportJob.perform_later(filename, false, 0, 19, 19)
    game.create_moves!
  end

  it 'can display the game (elm)' do
    visit "/games/#{game.id}"
    sleep 50

    expect(page).to have_content 'Bullock'
    expect(page).to have_content game.opening.ecocode

    expect(page).to have_content "Elm Chessboard 23 Moves"
    expect(page).to have_content 'React Chessboard'
    expect(page).to have_content 'React MoveList'
  end

  it 'can display the game moves (ruby)' do
    visit "/games/#{game.id}/moves"
    sleep 10

    expect(page).to have_content 'Sellick'
    expect(page).to have_content game.opening.ecocode
    expect(page).to have_content game.opening.name
  end
end