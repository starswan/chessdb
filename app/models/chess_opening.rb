#
# $Id$
#
# chess_openings has a class called 'Opening'
class ChessOpening < ApplicationRecord
  self.table_name = :openings

  OPENING_ALIASES = {
    'Amar (Paris) opening' => 'Amar Gambit',
    "Alekhine's defence" => "Alekhine Defense",
    'Benoni' => 'Benoni defence',
    "Bird" => "Bird's opening",
    "Blackmar-Diemer" => "Blackmar-Diemer Gambit",
    "Blackmar gambit" => "Blackmar-Diemer Gambit",
    'Budapest defence' => 'Budapest Gambit',
    'Budapest defence declined' => 'Budapest Gambit',
    'Budapest' => 'Budapest Gambit',
    'Catalan' => 'Catalan Opening',
    'Catalan opening' => 'Catalan Opening',
    'Caro-Kann defence' => 'Caro-Kann',
    'Caro-Kann Defence' => 'Caro-Kann',
    'Czech Benoni defence' => 'Czech Benoni',
    "Clemenz (Mead's,Basman's or de Klerk's) opening" => "Clemenz (Mead's, Basman's or de Klerk's) opening",
    'Benoni Defense: Czech Benoni Defense' => 'Czech Benoni',
    'Dutch' => 'Dutch defence',
    "Dunst (Sleipner,Heinrichsen) opening" => "Dunst (Sleipner, Heinrichsen) opening",
    'Evans gambit declined' => 'Evans Gambit',
    'English' => 'English opening',
    'English Opening' => 'English opening',
    'French defence' => 'French',
    'Four knights game' => 'Four knights',
    'Four Knights Game' => 'Four knights',
    "Gedult attack" => "Gedult's opening",
    'Giuoco piano' => 'Giuoco Piano',
    "Grob's attack" => 'Grob',
    'Gruenfeld' => 'Gruenfeld defence',
    'Latvian gambit' => 'Latvian counter-gambit',
    'Latvian' => 'Latvian counter-gambit',
    "King's Indian" => "King's Indian defence",
    'KGA' => "King's Gambit",
    "King's knight's gambit" => "King's Gambit",
    "King's gambit accepted" => "King's Gambit",
    "King's Gambit Accepted" => "King's Gambit",
    'KP' => "King's pawn opening",
    "King's pawn game" => "King's pawn opening",
    'Neo-Gruenfeld defence' => 'Neo-Gruenfeld',
    'Neo-Gruenfeld (Kemeri) defence' => 'Neo-Gruenfeld',
    'Modern' => 'Modern defence',
    'Modern Defense: Standard Line' => 'Modern defence',
    "Nimzo-Indian defence" => "Nimzo-Indian",
    'Old Benoni defence' => 'Old Benoni',
    'Old Indian defence' => 'Old Indian',
    "Petrov's defence" => 'Petrov',
    'Pirc defence' => 'Pirc',
    'Ponziani opening' => 'Ponziani',
    "Philidor's defence" => 'Philidor',
    "Polish (Sokolsky) opening" => "Polish (Sokolsky)",
    "Polish (Sokolsky)" => 'Polish',
    'QGA' => "Queen's Gambit Accepted",
    'QGD' => "Queen's Gambit Declined",
    "Queen's Gambit" => "Queen's Gambit Declined",
    "Queen's gambit accepted" => "Queen's Gambit Accepted",
    "Queen's gambit declined" => "Queen's Gambit Declined",
    "Queen's pawn" => "Queen's pawn game",
    "Queen's Pawn" => "Queen's pawn game",
    "Queen's Indian defence" => "Queen's Indian",
    'QGD Slav defence' => "Queen's Gambit Declined Slav",
    'QGD Slav' => "Queen's Gambit Declined Slav",
    'QGD Slav accepted' => "Queen's Gambit Declined Slav",
    "Queen's Gambit Declined Slav" => "Queen's Gambit Declined Slav",
    "Queen's Gambit Declined Slav accepted" => "Queen's Gambit Declined Slav",
    "Queen's Gambit Declined Slav defence" => "Queen's Gambit Declined Slav",
    "QP counter-gambit" => "Elephant Gambit",
    "QP counter-gambit (elephant gambit)" => "Elephant Gambit",
    "QGD semi-Slav" => "Queen's Gambit Declined, Semi-Slav",
    'Sicilian defence' => 'Sicilian',
    'Sicilian Defence' => 'Sicilian',
    'Sicilian Defense: Alapin Variation' => 'Sicilian, Alapin variation',
    'Reti opening' => 'Reti',
    'Robatsch defence' => 'Robatsch (modern) defence',
    "Russian variation" => "Russian",
    'Ruy Lopez (Spanish opening)' => 'Ruy Lopez',
    'two knights' => "Two knights defence",
    'two knights defence' => "Two knights defence",
    "Two knights defence (Modern bishop's opening)" => 'Two knights defence',
    'Three knights' => 'Three knights game',
    'Scotch game' => 'Scotch',
    'Scotch opening' => 'Scotch',
    'Scandinavian defence' => 'Scandinavian',
    'Scandinavian (centre counter) defence' => 'Scandinavian',
    'Vienna game' => 'Vienna',
    "Semi-Benoni (`blockade variation')" => "Semi-Benoni ('blockade variation')",
    "Trompovsky attack (Ruth,Opovcensky opening)" => "Trompovsky attack (Ruth, Opovcensky opening)",
    "Queen's pawn, Englund gambit" => "Englund Gambit",
    "Queen's pawn, Torre attack" => "Torre attack",
    "Tennison (Lemberg,Zukertort) gambit" => "Tennison (Lemberg, Zukertort) Gambit",
    "Nimzo-Indian, e3" => "Nimzo-Indian, 4.e3",
    "Nimzo-Indian, 4.e3 e8g8" => "Nimzo-Indian, 4.e3 O-O"
  }.freeze
  VARIATION_ALIASES = {
    "Advance, Nimzovich system" => "Advance, Nimzovich variation",
    "Alapin's variation (2.c3)" => "Alapin variation",
    "advance variation" => "Advance",
    "Anglo-Gruenfeld defense" => "Anglo-Gruenfeld",
    "Benko's opening, reversed Alekhine" => "reversed Alekhine",
    "Boleslavsky variation" => "Boleslavsky",
    "Canal-Sokolsky (Nimzovich-Rossolimo, Moscow) attack" => "Canal-Sokolsky attack",
    "Caro-Kann Defense: Classical Variation" => "Classical Variation",
    "Caro-Kann Defense: Tartakower Variation" => "Tartakower Variation",
    'Charlick (Englund) gambit' => 'Englund Gambit',
    "Chekhover variation" => "Chekhover",
    'Closed defence' => "Closed",
    "Dutch variation, main line" => "Dutch variation",
    'Dragon variation' => "Dragon",
    'Franco-Indian (Keres) defence' => 'Keres defence',
    'Four Knights Game: Gunsberg Variation' => 'Gunsberg variation',
    'Four Knights Game: Spanish Variation' => 'Spanish variation',
    "Four pawns attack, main line" => "Four pawns attack - main line",
    'Panov-Botvinnik Variation' => 'Panov-Botvinnik attack',
    "Kan variation" => "Kan",
    'Gurgenidze counter-attack' => 'Gurgenidze system',
    'Labourdonnais-Loewenthal variation' => 'Kalashnikov',
    'Labourdonnais-Loewenthal (Kalashnikov) variation' => 'Kalashnikov',
    'Pelikan (Lasker/Sveshnikov) variation' => 'Sveshnikov variation',
    "Pelikan" => "Sveshnikov variation",
    'Scheveningen, classical main line' => 'Scheveningen, classical',
    'French Defense: Steinitz Variation/ Boleslavsky Variation' => 'Steinitz, Boleslavsky variation',
    "Grob, Fritz gambit" => "Fritz Gambit",
    "Nescafe frappe attack" => "Nescafe Frappe attack",
    "Mokele mbembe (buecker) variation" => "Mokele Mbembe (Buecker) variation",
    "Meran variation" => "Meran",
    "Saemisch, main line" => "Saemisch variation",
    "Neo Catalan accepted" => "Neo Catalan",
    "4.e3 e8g8, 5.Nf3 d7d5" => "4.e3 O-O, 5.Nf3 d5",
    "4.e3 e8g8, 5.Nf3, without ...d5" => "4.e3 O-O, 5.Nf3, without ...d5",
    "e3, Huebner variation" => "Huebner variation",
    "Modern variation" => "Modern",
    "Fajarowicz variation" => "Fajarowicz",
    "Panov-Botvinnik attack" => "Panov-Botvinnik",
    "Leningrad variation" => "Leningrad, main variation",
    "Exchange variation" => "Exchange",
    "Classical variation" => "Classical",
    "Orthodox variation" => "Orthodox",
    "Bremen" => "Bremen system",
    "Sozin attack" => "Sozin",
    "Averbakh system" => "Averbakh",
    "Four knights system" => "Four knights",
    "Hanham variation" => "Hanham",
    "Scheveningen (Paulsen)" => "Scheveningen",
    "Scheveningen variation" => "Scheveningen",
    "Sozen attack" => "Sozin",
    "Taimanov (Bastrikov) variation" => "Taimanov",
    "Taimanov variation" => "Taimanov",
    "Alekhine variation" => "Alekhine",
    "Ilyin-Genevsky" => "Ilyin-Genevsky variation",
    "Stonewall variation" => "Stonewall",
    "Advance variation" => "Advance",
    "Anglo-Gruenfeld defense" => "Anglo-Gruenfeld",
    "Nimzovich system" => "Nimzovich variation",
    "Winawer (Nimzovich) variation" => "Winawer",
    "Dutch with c4 & Nc3" => "c4 and Nc3",
    "Dutch with c4 & g3" => "c4 and g3",
    "Falkbeer counter-gambit" => "Falkbeer, counter-gambit",
    "Urusov gambit, Panov variation" => "Urusov gambit - Panov variation",
  }.freeze
  IRREGULAR_NAMES = {
    'Benko gambit accepted' => 'Benko Gambit',
    "Alekhine Defense: Modern Variation" => "Alekhine Defense",
    'Benko gambit half accepted' => 'Benko Gambit',
    "Benko's opening, reversed Alekhine" => "Benko's opening",
    'Mujannah opening' => "Bird's opening",
    'Boden-Kieseritsky gambit' => 'Vienna',
    'Blumenfeld counter-gambit accepted' => 'Blumenfeld counter-gambit',
    'Caro-Masi defence' => 'Caro-Kann',
    'Caro-Kann Defense: Classical Variation' => 'Caro-Kann',
    'Caro-Kann Defense: Tartakower Variation' => 'Caro-Kann',
    'de Bruycker defence' => 'Caro-Kann',
    'Vulture defence' => 'Czech Benoni',
    'Dutch with c4 & Nc3' => 'Dutch defence',
    'Dutch with c4 & g3' => 'Dutch defence',
    'Dutch-Indian' => 'Dutch defence',
    'English,1...Nf6 (Anglo-Indian defense)' => 'English opening',
    "English Opening: King's English Variation" => 'English opening',
    'English orang-utan' => 'English opening',
    'English Opening: Mikenas-Carls Variation' => 'English opening',
    "English Opening: Symmetrical Variation" => "English opening",
    'Evans counter-gambit' => 'Evans Gambit',
    'French Defense: Steinitz Variation' => 'French',
    'Four Knights Game: Gunsberg Variation' => 'Four knights',
    'Four Knights Game: Spanish Variation' => 'Four knights',
    "Giuoco Pianissimo" => "Giuoco Piano",
    "Grob, Fritz gambit" => "Grob's attack",
    'Gruenfeld with e3 & Qb3' => 'Gruenfeld defence',
    'Gruenfeld with e3 Bd3' => 'Gruenfeld defence',
    'Gruenfeld with Bf4 e3' => 'Gruenfeld defence',
    "King's Indian with e4 & g3" => "King's Indian defence",
    'Woozle defence' => 'Old Benoni',
    'Hawk (Habichd) defence' => 'Old Benoni',
    'Petrov three knights game' => 'Petrov',
    'Ponziani counter-gambit' => 'Ponziani',
    'Polish defence' => "Queen's pawn game",
    'Kevitz-Trajkovich defence' => "Queen's Indian",
    "Queen's Indian accelerated" => "Queen's Indian",
    'Reti accepted' => 'Reti',
    'Norwegian defence' => 'Modern defence',
    'Pterodactyl defence' => 'Modern defence',
    "Semi-Slav Defense: Accelerated Move Order" => "Queen's Gambit Declined, Semi-Slav",
    'Scandinavian gambit' => 'Scandinavian',
    'Tayler opening' => 'Scotch',
    'Sicilian Defense: Canal-Sokolsky Attack' => 'Sicilian',
    'Scandinavian Defense: Mieses-Kotroc Variation' => 'Scandinavian',
    'Sicilian Defense: Alapin Variation' => 'Sicilian Defense',
    "Guatemala defence" => "Owen defence",
    'Reti v Dutch' => 'Reti',
    'KGD' => "King's Gambit Declined",
  }.freeze

  has_many :games, foreign_key: :opening_id, dependent: :destroy

  validates :ecocode, format: { with: /\A[A-Z]\d{2}\z/ }
  # Try not to allow openings with just an ECO Code
  validates_presence_of :name

  @@openings = ChessOpenings.new

  class << self
    # :nocov #
    def find_opening ecocode, tag_name, tag_variation, raw_pgn
      if tag_name&.include?(',') && tag_variation.blank? && (tag_name&.include?('variation') || tag_name&.exclude?(')'))
        split_name = tag_name.split(',')
        tag_name = split_name.first
        variation = split_name[1..].join(',')
      else
        name = tag_name
        variation = tag_variation
      end
      if IRREGULAR_NAMES.key?(name)
        if variation.blank?
          name, variation = IRREGULAR_NAMES.fetch(name), name
        else
          name, variation = IRREGULAR_NAMES.fetch(name), "#{name}, #{variation}"
        end
      end
      name = OPENING_ALIASES.fetch(name, name)
      variation = tweak_variation(variation)

      if name.blank? || variation.blank?
        first_move_line = raw_pgn.split("\n").detect { |x| x.starts_with? "1." }
        gem_opening = @@openings.from_string(first_move_line)
        logger.info "Opening from #{first_move_line} #{gem_opening.eco_code} #{gem_opening.name} #{gem_opening.moves}"
        chess_opening_name = OPENING_ALIASES.fetch(gem_opening.name, gem_opening.name)
        if chess_opening_name.include?(", ") && (chess_opening_name.include?("variation") || chess_opening_name.exclude?("("))
          chess_opening = ChessOpening.find_by(name: chess_opening_name)
          if chess_opening.present?
            chess_opening
          else
            names = chess_opening_name.split(", ")
            if names.size == 2
              variation = tweak_variation(names[1..].join(", "))
              ChessOpening.find_or_create_by! name: names[0], variation: variation do |co|
                co.ecocode = gem_opening.eco_code
              end
            else
              variation = tweak_variation(names[2..].join(", "))
              ChessOpening.find_or_create_by! name: names[0..1].join(", "), variation: variation do |co|
                co.ecocode = gem_opening.eco_code
              end
            end
          end
        else
          logger.info("Unknown: [#{tag_name}] [#{tag_variation}] [#{first_move_line}] -> [#{gem_opening.name} #{gem_opening.eco_code} #{gem_opening.moves}]")
          if ChessOpening.find_by(name: chess_opening_name, ecocode: gem_opening.eco_code).present?
            # If there is an existing ECO code for this opening, then it's probably good - so don't override
            ChessOpening.find_or_create_by! name: chess_opening_name, ecocode: gem_opening.eco_code, variation: "Unknown"
          else
            ChessOpening.find_or_create_by! name: chess_opening_name, variation: "Unknown" do |co|
              co.ecocode = ecocode
            end
          end
        end
      else
        var_names = variation.split(", ")
        if var_names.size == 1
          ChessOpening.find_or_create_by! name: name, variation: variation do |co|
            co.ecocode = ecocode
          end
        else
          ChessOpening.find_or_create_by! name: "#{name}, #{var_names[0]}", variation: var_names[1..].join(", ") do |co|
            co.ecocode = ecocode
          end
        end
      end
    end
    # :nocov #

    private

    def tweak_variation variation
      VARIATION_ALIASES.fetch(variation, variation)
      if variation.present?
        #  avoid the automatic with - it might create too many variations
        # variation.gsub(" with ", ", ").gsub("`", "'")
        variation.gsub("`", "'")
      else
        variation
      end
    end
    # def move_text(move)
    #   if move
    #     piece = move.fetch(:piece)
    #     dest_square = Bchess::Pawn.new("w", move.fetch(:column), move.fetch(:row)).to_s.last(2)
    #     if piece.name == ''
    #       "#{dest_square}"
    #     else
    #       "#{piece.to_s.first}#{dest_square}"
    #     end
    #   end
    # end
  end
end
