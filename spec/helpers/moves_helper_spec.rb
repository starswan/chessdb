require 'rails_helper'

RSpec.describe MovesHelper, type: :helper do
  describe '#square_to_pos' do
    it 'translates h1' do
      expect(helper.square_to_pos('h1')).to eq([7, 7])
    end

    it 'translates a1' do
      expect(helper.square_to_pos('a1')).to eq([7, 0])
    end

    it 'translates a8' do
      expect(helper.square_to_pos('a8')).to eq([0, 0])
    end

    it 'translates h8' do
      expect(helper.square_to_pos('h8')).to eq([0, 7])
    end

    it 'translates e2' do
      expect(helper.square_to_pos('e2')).to eq([6, 4])
    end
  end

  describe '#position_for' do
    let(:kingspawn) { build(:move, number: 1, from: 'e2', to: 'e4') }

    it 'does e2e4' do
      expect(position_for([kingspawn])).to eq(["rnbqkbnr", "pppppppp", "        ", "        ", "    P   ", "        ", "PPPP PPP", "RNBQKBNR"])
    end
  end
end
