# frozen_string_literal: true
#
# $Id$
#
require 'rails_helper'

RSpec.describe PgnImportJob, type: :job do
  GAME_DATA = <<~EOF
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

  it 'parses a game' do
    expect {
      described_class.perform_now 'fred', GAME_DATA
    }.to change(Game, :count).by(1)
  end

  EXD5 = <<~EXD5EOF
    [Event "2016 British Chess Championships"]
    [Site "Bournemouth Pavilions, Bournemouth"]
    [Date "2016.07.25"]
    [Round "1"]
    [Board "7"]
    [White "Fowler, David J"]
    [Black "Egan, William J"]
    [Result "1-0"]
    [ECO "A00"]
    [WhiteElo "1663"]
    [BlackElo "124"]
    [PlyCount "59"]
    [EventDate "2016.07.25"]
    [EventRounds "5"]
    [EventCountry "ENG"]

    1. e4 c6 2. d4 d5 3. exd5 cxd5 4. Bd3 Nc6 5. c3 g6 6. f4 Nh6 7. Nf3 Bf5 8. O-O
    Bxd3 9. Qxd3 e6 10. Nbd2 Bg7 11. Ne5 O-O 12. Ndf3 Ne7 13. Qe2 Nef5 14. Bd2 Nd6
    15. Rae1 Re8 16. Bc1 Qc7 17. Nd2 Rac8 18. Rf3 f6 19. Nd3 b6 20. Re3 f5 21. Rxe6
    Ne4 22. Rxe8+ Rxe8 23. Ne5 Bxe5 24. fxe5 Qc6 25. Nxe4 fxe4 26. Bxh6 Qe6 27. Rf1
    Qe7 28. Qf2 a6 29. Qf6 Qxf6 30. Rxf6 1-0
  EXD5EOF

  it 'parses another game' do
    expect {
      described_class.perform_now 'fred2', EXD5
    }.to change(Game, :count).by(1)
  end
end
