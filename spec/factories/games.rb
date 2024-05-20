# frozen_string_literal: true
#
# $Id$
#
FactoryBot.define do
  factory :player do
    first_name { 'Fred' }
    last_name { 'Bloggs' }
  end

  factory :opening, class: ChessOpening do
    sequence(:ecocode) do |n|
      letter = 'ABCDE'[n / 100]
      "#{letter}%02d" % ( n % 100)
    end
    sequence(:name) { "Chess Opening #{_1}" }
  end

  factory :game do
    association :opening
    white { build(:player) }
    black { build(:player) }
    white_elo { 1900 }
    black_elo { 1900 }
    date { Date.today }
    result { '1-0' }
    number_of_moves { 20 }
    site { 'Somewhere' }
    pgn do
      '[Event "2016 British Chess Championships"]
[Site "Bournemouth Pavilions, Bournemouth"]
[Date "2016.07.25"]
[Round "1"]
[Board "11"]
[White "Nielsen, Jorgen H"]
[Black "Dicks, Steve"]
[Result "1-0"]
[ECO "A00"]
[WhiteElo "1805"]
[BlackElo "120"]
[PlyCount "89"]
[EventDate "2016.07.25"]
[EventRounds "5"]
[EventCountry "ENG"]

1. Nc3 d5 2. e4 d4 3. Nce2 Nc6 4. Ng3 e5 5. Bc4 Nf6 6. d3 Bb4+ 7. Bd2 Bxd2+ 8.
Qxd2 Qd6 9. Nf3 h6 10. O-O Be6 11. Nf5 Bxf5 12. exf5 Rf8 13. Bb5 O-O-O 14. Bxc6
bxc6 15. Qa5 Nd5 16. Qxa7 Rfe8 17. a3 c5 18. Nd2 Nb6 19. Ne4 Qc6 20. Qa5 Rd5
21. Qd2 c4 22. Qe2 Rb5 23. Rfb1 Na4 24. dxc4 Rxb2 25. Rxb2 Nxb2 26. Nd2 e4 27.
Rb1 Na4 28. Qg4 Nc3 29. f6+ Qe6 30. Qxe6+ Rxe6 31. fxg7 Rg6 32. Re1 f5 33. Nb3
Rxg7 34. Nxd4 Rf7 35. Re3 Na4 36. f3 Nb2 37. c5 Nc4 38. Rc3 Nd2 39. c6 Kb8 40.
a4 Ka7 41. Nb3 Nb1 42. Re3 Rf6 43. Nd4 Nd2 44. Re2 Nb1 45. c4 1-0'
    end
  end

  factory :move do
    number  { 1 }
    move { 'e4' }
    from { 'e2' }
    to { 'e4' }
    piece { 'P' }
    fen { '8/8/8/8/8/8/8/8' }

    trait :black do
      move { 'e5' }
      from { 'e7' }
      to { 'e5' }
      piece { 'p' }
    end
  end
end
