# frozen_string_literal: true
#
# $Id$
#
require 'rails_helper'

RSpec.describe PgnFileImportJob, type: :job do
  SHORT_GAME_DATA = <<~EOF
    [Event "St. Pauli Open 2012"]
    [Site "Hamburg GER"]
    [Date "2012.07.07"]
    [Round "1.18"]
    [White "Kahlert,T"]
    [Black "Kosovs,Ernst"]
    [Result "*"]
    [WhiteElo "2229"]
    [BlackElo "1974"]
    [WhiteFideId "4625242"]
    [BlackFideId "12921289"]
    [EventDate "2012.07.07"]

    * *

    [Event "St. Pauli Open 2012"]
    [Site "Hamburg GER"]
    [Date "2012.07.07"]
    [Round "1.19"]
    [White "Krotofil,K"]
    [Black "Putzbach,G"]
    [Result "0-1"]
    [BlackTitle "FM"]
    [WhiteElo "1962"]
    [BlackElo "2228"]
    [ECO "D31"]
    [Opening "QGD"]
    [Variation "3.Nc3"]
    [WhiteFideId "4666887"]
    [BlackFideId "4611128"]
    [EventDate "2012.07.07"]

    1. d4 d5 2. c4 e6 3. Nc3 f5 4. Nf3 c6 5. e3 Nf6 6. Bd3 Be7 7. O-O O-O 8. b3 Ne4
    9. Bb2 Nd7 10. Qc2 Qe8 11. Rac1 g5 12. Ne5 Nxe5 13. dxe5 Bd7 14. Qe2 h5 15. f3
    Nxc3 16. Rxc3 h4 17. h3 Qg6 18. Rcc1 Rad8 19. c5 Be8 20. Bd4 Qh6 21. Qd1 Bh5 22.
    Be2 Kh8 23. f4 Bxe2 24. Qxe2 Rg8 25. Kh1 Rg6 26. Qf2 Rdg8 27. Rg1 g4 28. Rcf1
    Kh7 29. Qe2 Kg7 30. Kh2 Kf7 31. b4 Qg7 32. Qd1 gxh3 33. gxh3 Rg2+ 34. Kh1 Qg3
    35. Qh5+ Kf8 36. Qh6+ Ke8 0-1
  EOF

  it 'is able to ignore a short game' do
    expect(PgnFileImportJob::PgnReader.new(SHORT_GAME_DATA.split("\n"), Rails.logger).to_a.size).to eq(1)
  end
end
