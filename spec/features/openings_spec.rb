require "rails_helper"

RSpec.describe "root path", :js, type: :feature do
  before do
    # create(:opening)
    create(:game, opening: build(:opening))
  end

  let(:game) { Game.last }

  it 'can visit the root', :js do
    visit '/'
    sleep 2

    expect(page).to have_content 'Openings'
    expect(page).to have_content game.opening.ecocode
    expect(page).to have_content game.opening.name
  end
end