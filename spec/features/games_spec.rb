require "rails_helper"

RSpec.describe "showing a game", :js, type: :feature do
  let(:game) { create(:game, white: build(:player, last_name: 'Smith'), moves: [build(:move), build(:move, :black)], opening: build(:opening)) }

  it 'can display the game', :js do
    visit "/games/#{game.id}"
    sleep 20

    expect(page).to have_content 'Smith'
    expect(page).to have_content game.opening.ecocode
    expect(page).to have_content game.opening.name
  end
end