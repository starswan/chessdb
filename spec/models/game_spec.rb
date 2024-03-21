# frozen_string_literal: true
#
# $Id$
#
require 'rails_helper'

RSpec.describe Game, type: :model do
  # xit "can cope with Acor vs Tedori" do
  #   # This move seems to break the PGN parser in some weird way - calling PGN::Game.positions results in:
  #   # TypeError: no implicit conversion from nil to integer but doesn't give a line number inside the PGN gem?
  #   moves = %w{e4 d5 exd5 Qxd5 Nc3 Qd8 g3 Nf6 Bg2 c6 d3 Bg4 Nge2 e6 h3 Bxe2 Qxe2 Nbd7 g4 Be7 Bd2 a5 O-O O-O f4 a4 a3 Nd5 Kh1 Nc3 Bc3 Nd5}
  #   # This s the actual complete game
  #   #moves = %w{e4 d5 exd5 Qxd5 Nc3 Qd8 g3 Nf6 Bg2 c6 d3 Bg4 Nge2 e6 h3 Bxe2 Qxe2 Nbd7 g4 Be7 Bd2 a5 O-O O-O f4 a4 a3 Nd5 Kh1 Nc3 Bc3 Nd5 Bd2}
  #   # The Bc3 is probably the issue here - I suspect this is wrong as Nd5 isn't possible if the N is captured and Bc3 should be Bxc3
  #   game_from_moves moves
  # end

  context 'games from moves' do
    let(:white_player) { 'Bloggs, Fred' }
    let(:black_player) { 'Smith, Jim' }
    let(:game) { game_from_moves moves, white_player, black_player }

    describe "create a game from a sample PGN" do
      let(:moves) do
        moves = %w{e4 c5 Nf3 Nc6 Bb5 g6 Bxc6 bxc6 O-O Bg7 Re1 Nh6 c3 O-O d4 cxd4 cxd4 d5 e5 Bg4 Nbd2 f6 h3 Bxf3 Nxf3 fxe5 Bxh6 Bxh6}
        moves += %w{Rxe5 Bg7 Re6 Qd7 Qe2 Rfe8 Re1 Bf6 Qd2 Rac8 b4 Kg7}
        moves += %w{Nh2 Rf8 Ng4 Rf7 h4 Rd8 h5 g5 h6+ Kf8 Ne5 Bxe5 R1xe5 Rf6}
        moves += %w{Qxg5 Qxe6 Rxe6 Rxe6 Qf5+ Rf6 Qxh7 Ke8 g4 Kd7 g5 Rff8 g6 Rh8 Qxh8 Rxh8 g7 Rg8 Kf1}
        moves
      end

      it 'parses correctly' do
        expect(game.pgn.size).to eq(586)
      end

      it 'can be expanded' do
        game.create_moves!
        expect(game.moves[8].from).to eq('e1')
        expect(game.moves[8].to).to eq('g1')
        expect(game.moves[13].from).to eq('e8')
        expect(game.moves[13].to).to eq('g8')
      end
    end

    describe 'De Jong vs Verlinde' do
      let(:moves) {
        %w{d4 Nf6 c4 g6 Nc3 Bg7 e4 d6 Be2 O-O Nf3 e5 Be3 Nc6 d5 Ne7 Nd2 Nd7 f3 f5 b4 b6 Nb3 Nf6 c5 f4 Bf2 g5 a4 h5 a5 bxc5 bxc5 Ng6 a6 g4 Na5 Nh7 Nc6 Qg5 Nb5 g3 Bg1 Nh4 Kd2 Nxg2 Nxc7 Bd7 Nxa8 Rxa8 Qb3 Nf6 Kc2 Ne1+ Rxe1 g2 Bf2 gxh1=Q Rxh1 Qg2 Rf1 dxc5 Qb7 Re8 Qxa7 Bxc6 dxc6 Ng4 Qd7
         Ne3+ Kc3 Nxf1 Qxe8+ Bf8 Bc4+ Kh7 Qxh5+ Bh6 c7 Qxf2 Qf5+}
      }
      let(:white_player) { 'De Jong' }
      let(:black_player) { 'Verlinde' }

      it 'parses correctly' do
        expect(game.pgn.size).to eq(622)
      end
    end

    describe "Ayala Pena vs Atoufi" do
      let(:moves) { %w{d4 Nf6 c4 g6 Nc3 Bg7 e4 O-O Be3 d6 f3 a6 Qd2 Nbd7 Nh3 c5 Nf2 e6 Be2 b6 O-O Bb7 Rfd1 Re8 Rac1 Qe7 Bf1 Red8 b3 Qf8 d5 e5 Rb1 Nh5 b4 Bc8 bxc5 bxc5 Na4 f5 exf5 gxf5 Bg5 Re8 Nb6 Nxb6 Rxb6 h6 Bh4 e4 Qc2 e3 Nd3 Bd4 Be2 f4 Nb4 Bf5 Qa4 a5 Nc6 Bf6 Be1 Kh8 Bd3 e2 Bxf5 exd1=Q Qxd1 Qg7 Be6 a4 Kf1 Qh7 a3 Rf8 Bf2 Rae8 Ra6 Ng7 Bd7 Ra8 Rxa8 Rxa8 g4 h5 Kg2 hxg4 Bxg4 Bb2 Be1 Nf5 Qe2 Ne3+ Kg1 Qc2 Kf2 Qxe2+ Kxe2 Nxc4 Bf5 Nxa3 Na5 Nb5} }

      it 'parses correctly' do
        expect(game.pgn.size).to eq(762)
      end
    end

    describe "Popov vs Luskotov" do
      let(:moves) { %w{e4 e5 Nf3 Nf6 Nxe5 d6 Nf3 Nxe4 c4 d5 Nc3 Bc5 d4 Bb4 Qc2 Qe7 Be3 Bf5 Qb3 O-O cxd5 Re8 Ne5 Nd7 Be2 Nxe5 dxe5 Bxc3+ bxc3 Qxe5 O-O Nxc3 Bf3 Be4 Bxe4 Nxe4 Qxb7 Nc3 Bxa7 Nxd5 a3 Nc3 Be3 c5 Qb2 Rab8 Qc2 c4 a4 Rbc8 a5 Nd5 a6 Nxe3 fxe3 Qxe3+ Qf2 Qxf2+ Rxf2 Ra8 Rc2 Rec8 h4 g6 Ra4 c3 Ra3 Kg7 Kf2 Rc6 Rcxc3 Rf6+ Kg3 Rfxa6 Rxa6 Rxa6 Rc5 Ra3+ Kf2 Ra4 g3 Kf6 Rb5 Re4 Ra5 Re5 Ra7 h5 Rb7 Ra5 Rc7 Ke6 Kf3 f6 Rc3 Ke5 Rb3 Rc5 Ra3 g5 hxg5 fxg5 Ra2 Kf5 Rb2 g4+ Kf2 Ke4 Re2+ Kd3 Re3+ Kd4 Re2 Rf5+ Kg2 Re5 Ra2 Kc3 Ra3+ Kb2 Ra6 Rd5 Rc6 Rd2+ Kf1 Rd3 Kf2 Rd5 Rc7 Rf5+ Kg2 Kb3 Rc8 Kb4 Rc7 Rc5 Ra7 Kc3 Rd7 Kc4 Rd1 Ra5 Kf2 Kc3 Rd8 Rf5+ Kg2 Kc4 Rd1 Rf3 Rh1 Rf5 Rd1 Rd5 Rc1+ Kd3 Rd1+ Ke4 Re1+ Kf5 Re2 Rd4 Ra2 Ke4 Re2+ Kd3 Re5 Rc4 Rxh5 Ke4 Rg5 Rc2+ Kg1 Kf3 Rf5+ Kxg3 Rf1 Rg2+ Kh1 Rf2 Rb1 Kh3 Ra1 g3 Rb1 Rf1+ Rxf1 g2+ Kg1 gxf1=R+ Kxf1} }

      it 'parses correctly' do
        expect(game.pgn.size).to eq(1324)
      end
    end

    describe "Birkisson,Bjorn Holm vs Jonsson,Bjorg (under promote to knight)" do
      let(:moves) { %w{e4 c5 d4 cxd4 c3 dxc3 Nxc3 Nc6 Nf3 e6 Bc4 Qc7 O-O Nf6 Nb5 Qb8 e5 a6 exf6 axb5 fxg7 Bxg7 Bxb5 O-O Qe2 d5 a4 Bd7 Ra3 Qd6 Rd1 Rad8 Nh4 Ne7 Bxd7 Rxd7 Rh3 Qe5 Qf3 Ng6 Be3 d4 Bd2 Rd5 Qd3 Qf6 Nxg6 hxg6 Bh6 Rc8 Bxg7 Kxg7 Qd2 Qg5 Qxg5 Rxg5 Rhd3 Rd5 Kf1 Rc4 b3 Rb4 Rc1 e5 f3 f5 Re1 Kf6 h4 Rd6 Re2 Rdb6 g4 Rxb3 g5+ Ke6 Rxd4 Rxf3+ Kg2 Rbb3 Rd8 e4 Rh8 Rg3+ Kh2 Rh3+ Kg1 Rbg3+ Rg2 f4 Rxg3 Rxg3+ Kf1 Kf5 Rb8 Ra3 Rxb7 Rxa4 Rb5+ Kg4 Rb6 Kf3 Rb1 e3 h5 gxh5 g6 Ra6 Kg1 Rxg6+ Kh2 e2 Rf1+ exf1=N+ Kh1 Ng3+ Kh2 Ra6 Kh3 Nf5 Kh2 Ra1} }

      it 'parses correctly' do
        expect(game.pgn.size).to eq(890)
      end
    end

    describe 'Lopez Rebert,P vs Madina Yadarola,M1' do
      let(:moves) { %w{e4 c5 Nf3 e6 c3 Nf6 e5 Nd5 d4 cxd4 cxd4 d6 Nc3 Nxc3 bxc3 Qc7 Qb3 Nc6 Bf4 dxe5 Nxe5 Bd6 Bg3 Bxe5 dxe5 O-O f4 Rd8 Be2 Bd7 Bh4 Rdc8 O-O Na5 Qb4 Bc6 c4 b6 c5 Qb7 cxb6 axb6 Rf2 Bd5 Rb1 Bxa2 Bf3 Bd5 Bxd5 Qxd5 Qxb6 Nc4 Qb3 Qd4 Rd1 Ra1 Rdf1 Nd2} }

      it 'parses correctly' do
        expect(game.pgn.size).to eq(490)
      end
    end

    # ambiguous Rf1 breaks PGN library
    # xit 'can read Lopez Rebert,P vs Madina Yadarola,M1 really' do
    #   moves = %w{e4 c5 Nf3 e6 c3 Nf6 e5 Nd5 d4 cxd4 cxd4 d6 Nc3 Nxc3 bxc3 Qc7 Qb3 Nc6 Bf4 dxe5 Nxe5 Bd6 Bg3 Bxe5 dxe5 O-O f4 Rd8 Be2 Bd7 Bh4 Rdc8 O-O Na5 Qb4 Bc6 c4 b6 c5 Qb7 cxb6 axb6 Rf2 Bd5 Rb1 Bxa2 Bf3 Bd5 Bxd5 Qxd5 Qxb6 Nc4 Qb3 Qd4 Rd1 Ra1 Rf1 Nd2}
    #
    #   game_from_moves moves
    # end

    describe "Getx vs Devreaux" do
      let(:moves) { %w{e4 e6 d4 d5 Nd2 Be7 Bd3 c5 dxc5 Nf6 Qe2 a5 Ngf3 Na6 Bb5+ Bd7 Ne5 Nb4 Ndf3 Bxb5 Qxb5+ Kf8 O-O Nxe4 c3 Nc6 Be3 Qc7 Bf4 Qc8 c4 f6 Nd3 a4 cxd5 exd5 Nc1 Ra5 Qe2 Nxc5 Bd2 Ra8 Be3 Ne6 Rd1 Qd7 Qc2 g6 Ne2 Kf7 Nc3 Nb4 Qe2 a3 bxa3 Rxa3 Nb5 Rxa2 Rxa2 Nxa2 Qxa2 Qxb5 Rxd5 Ra8 Rxb5 Rxa2 g3 Rc2 Rxb7 Rc7 Rxc7} }

      it 'parses correctly' do
        expect(game.pgn.size).to eq(576)
      end
    end

    describe "Hu vs Solomon (underpromote to a Bishop!)" do
      let(:moves) { %w{d4 Nf6 Nf3 g6 g3 Bg7 Bg2 O-O O-O d5 c4 c6 cxd5 cxd5 Qb3 Nc6 Nc3 Ne4 Rd1 a6 Bf4 Nxc3 bxc3 Na5 Qb4 Bg4 h3 Bf5 Ne5 Rc8 g4 Be6 Rac1 b5 Nd3 Rc4 Qb2 Bc8 e3 Re8 Bf1 Rc6 a4 Nc4 Qa2 bxa4 Nb4 Qd7 Nxc6 Qxc6 Rb1 e5 Bxc4 dxc4 d5 Qd6 Bg3 Bd7 Qxc4 Bf8 Rb7 a3 Qc7 Qxc7 Rxc7 Ba4 Ra1 Bd6 Ra7 Bb5 Bh4 Kg7 Rb7 Rc8 Rb6 Bc5 Bf6+ Kf8 Rb7 Bd6 Rc1 a2 Ra1 Bc4 e4 Ke8 Kg2 Rb8 Rxb8+ Bxb8 Bg5 Bd6 Bc1 a5 Bb2 a4 Re1 a3 Ba1 Kd7 g5 Bc5 h4 Be7 Kf3 Kd6 Kg4 Bd8 h5 Bb6 hxg6 hxg6 Kf3 Bd8 Rg1 Be7 Ke3 Kd7 Rg2 Bf1 Rg3 Bc5+ Kd2 Bc4 Rf3 Ke8 Rf6 Bb5 Kc2 Ba4+ Kc1 Be7 c4 Bb3 c5 Bxc5 Bxe5 Be7 Kd2 Bxf6 gxf6 g5 Ke3 Kd7 Bc3 Bc2 Kd4 g4 e5 Bd1 Kc5 Bf3 e6+ fxe6 f7 Ke7 dxe6 Kf8 Kd6 g3 fxg3 Bg4 Ke5 a1=B Bxa1 a2 Bd4 a1=B Bxa1 Bxe6} }

      it 'parses correctly' do
        expect(game.pgn.size).to eq(1159)
      end
    end

    describe 'read Nikolovski vs Zlatanovic' do
      let(:moves) { %w{f4 g6 Nf3 Bg7 e3 d6 Nc3 e5 fxe5 dxe5 Bc4 Nh6 e4 Bg4 d3 Nc6 h3 Bxf3 Qxf3 Nd4 Qf2 O-O g4 Bf6 O-O Bg5 Nd5 Kg7 Bxg5 Qxg5 Nf6 Qf4 c3 Ne6 Qe1 Kxf6 Rxf4+ Nxf4 Qh4+ Kg7 g5 Ng8 d4 Rae8 dxe5 Ne6 Rf1 Re7 Rf6 Rfe8 Bxe6 Rxe6 Rxe6 Rxe6 Qf2 b6 Qd4 h6 gxh6+ Nxh6 Qd7 g5 Qxc7 a6 Kg2 Ng8 b4 Ne7 a4 Ng6 c4 Nxe5 Qc8 a5 bxa5 bxa5 Qc5 f6 Qxa5 Rc6 c5 Kg6 Qb5 f5 exf5+ Kxf5 a5 Re6 a6 Nc6 Qa4} }

      it 'parses correctly' do
        expect(game.pgn.size).to eq(690)
      end

      it 'can be expanded' do
        game.create_moves!
        expect(game.moves.detect { |m| m.number == 46 }.slice(:from, :to).symbolize_keys).to eq({from: 'a1', to: 'f1'})
        expect(game.moves.detect { |m| m.number == 52 }.slice(:from, :to).symbolize_keys).to eq({from: 'f6', to: 'e6'})
      end
    end
  end

  def game_from_moves(moves, white_player, black_player)
    # pgn = PGN::Game.new moves
    tags = { White: white_player, Black: black_player, Date: Date.today.to_s, Opening: 'blah', ECO: "A00", WhiteElo: 2000, BlackElo: 2000 }
    # Game.from_tags_and_moves(tags, pgn.moves).tap do |game|
    #   game.update!(result: '1-0', site: 'somewhere')
    # end
#    This should have worked and been an improvement...?
    move_data = moves.in_groups_of(2).map.with_index { |wb, index| "#{index + 1}. #{wb.first} #{wb.last}"}

    tag_pgn = <<EOF
[Date "#{tags.fetch(:Date)}"]
[White "#{tags.fetch(:White)}"]
[Black "#{tags.fetch(:Black)}"]
[ECO "#{tags.fetch(:ECO)}"]
[WhiteElo "#{tags.fetch(:WhiteElo)}"]
[BlackElo "#{tags.fetch(:BlackElo)}"]
[Site "somewhere"]
[Result "1-0"]
EOF

    move_pgn = "\n" + move_data.join(" ")
    game_pgn = tag_pgn + move_pgn
    parse_pgn(game_pgn).tap do |game|
      game.update!(result: '1-0', site: 'somewhere')
    end
  end

  def parse_pgn(filedata)
    games = Bchess::PGN::Parser.new(filedata).parse.map { |g| Bchess::PGN::Game.new(g).tap { |g| g.convert_body_to_moves } }
    games.map do |pgn|
      # puts "#{filename} #{index} #{pgn.tags['White']} vs #{pgn.tags['Black']}"
      Game.from_tags_and_moves({
        White: pgn.header.player_white, Black: pgn.header.player_black,
        WhiteElo: pgn.header.elo_white, BlackElo: pgn.header.elo_black,
        ECO: pgn.header.eco, Opening: pgn.header.opening, Variation: pgn.header.variation,
        Date: pgn.header.date }, pgn.moves, filedata).tap do |game|
        game.pgn = filedata
      end
      # puts "#{index} #{game.white.name} vs #{game.black.name} Opening #{game.opening}/#{game.variation}(#{game.ecocode}) on #{game.date} result #{game.result}"
    end.first
  end

  CRAP_TWICS = [1091].freeze
  PGN_DIR = (ENV['HOME'] + '/chessdb/shared/Twic/').freeze

  xit "can import a full set of PGN files" do
    Dir.entries(PGN_DIR).select { |k| k.ends_with? '.pgn' }.reject { |f| CRAP_TWICS.map { |t| "twic#{t}.pgn" }.include?(f) }.each do |f|
      puts "reading PGNS from #{f}"
      parse_pgn File.read(PGN_DIR + f)
    end
  end
end
