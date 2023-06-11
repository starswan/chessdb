# frozen_string_literal: true
#
# $Id$
#
require 'rails_helper'

RSpec.describe PgnFileSplitJob, type: :job do
  it 'is able to read a PGN file' do
    expect {
      described_class.perform_later(Rails.root.join('spec', 'files', '231059_1_4.pgn').to_s, false)
    }.to change(Game, :count).by(103)
  end
end
