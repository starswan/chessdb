require "rails_helper"

RSpec.describe "root path", type: :feature do
  before do
    create(:game, opening: build(:opening))
  end

  let(:game) { Game.last }

  it 'can visit the root' do
    visit '/'

    expect(page).to have_content 'Openings'
    expect(page).to have_content game.opening.ecocode
    expect(page).to have_content game.opening.name
  end
end