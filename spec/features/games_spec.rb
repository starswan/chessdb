require "rails_helper"

RSpec.describe "showing a game", :js, type: :feature do
  let(:game) { Game.last }

  before do
    PgnFileSplitJob.perform_later(Rails.root.join('spec', 'files', '231059_1_4.pgn').to_s, false)
    game.create_moves!
  end

  it 'can display the game', :js do
    visit "/games/#{game.id}"
    sleep 30

    # expect(page).to have_content 'Everitt'
    # expect(page).to have_content game.opening.ecocode
    # expect(page).to have_content game.opening.name
  end
end