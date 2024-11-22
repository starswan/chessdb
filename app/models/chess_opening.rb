#
# $Id$
#
# chess_openings has a class called 'Opening'
class ChessOpening < ApplicationRecord
  self.table_name = :openings

  OPENING_ALIASES = {
    'Amar (Paris) opening' => 'Amar gambit',
    "Alekhine's defence" => "Alekhine Defense",
    'Benoni' => 'Benoni defence',
    "Bird" => "Bird's opening",
    "Blackmar-Diemer" => "Blackmar-Diemer gambit",
    'Budapest defence' => 'Budapest gambit',
    'Budapest' => 'Budapest gambit',
    'Catalan' => 'Catalan Opening',
    'Catalan opening' => 'Catalan Opening',
    'Caro-Kann defence' => 'Caro-Kann',
    'Caro-Kann Defence' => 'Caro-Kann',
    'Czech Benoni defence' => 'Czech Benoni',
    "Clemenz (Mead's,Basman's or de Klerk's) opening" => "Clemenz (Mead's, Basman's or de Klerk's) opening",
    'Benoni Defense: Czech Benoni Defense' => 'Czech Benoni',
    'Dutch' => 'Dutch defence',
    "Dunst (Sleipner,Heinrichsen) opening" => "Dunst (Sleipner, Heinrichsen) opening",
    'Evans gambit declined' => 'Evans gambit',
    'English' => 'English opening',
    'English Opening' => 'English opening',
    'French defense' => 'French',
    'Four knights game' => 'Four knights',
    'Four Knights Game' => 'Four knights',
    "Gedult attack" => "Gedult's opening",
    'Giuoco piano' => 'Giuoco Piano',
    "Grob's attack" => 'Grob',
    'Gruenfeld' => 'Gruenfeld defence',
    'Latvian' => 'Latvian counter-gambit',
    'Latvian gambit' => 'Latvian counter-gambit',
    "King's Indian defence" => "King's Indian",
    'KGD' => "King's gambit",
    'KGA' => "King's gambit",
    "King's knight's gambit" => "King's gambit",
    'KP' => "King's pawn opening",
    "King's pawn game" => "King's pawn opening",
    'Neo-Gruenfeld defence' => 'Neo-Gruenfeld',
    'Neo-Gruenfeld (Kemeri) defence' => 'Neo-Gruenfeld',
    'Robatsch defence' => 'Modern defence',
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
    'QGA' => "Queen's gambit accepted",
    'QGD' => "Queen's Gambit Declined",
    "Queen's Gambit" => "Queen's Gambit Declined",
    "Queen's gambit declined" => "Queen's Gambit Declined",
    "Queen's pawn" => "Queen's pawn game",
    "Queen's Pawn" => "Queen's pawn game",
    "Queen's Indian defence" => "Queen's Indian",
    'Sicilian defence' => 'Sicilian',
    'Sicilian Defence' => 'Sicilian',
    'Sicilian Defense: Alapin Variation' => 'Sicilian',
    'Reti opening' => 'Reti',
    'Reti accepted' => 'Reti',
    'Reti v Dutch' => 'Reti',
    'Robatsch (modern) defence' => 'Modern defence',
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
  }.freeze
  VARIATION_ALIASES = {
    "Benko's opening, reversed Alekhine" => "reversed Alekhine",
    'Charlick (Englund) gambit' => 'Englund gambit',
    'Franco-Indian (Keres) defence' => 'Keres defence',
    'Four Knights Game: Gunsberg Variation' => 'Gunsberg variation',
    'Four Knights Game: Spanish Variation' => 'Spanish variation',
    'Panov-Botvinnik Variation' => 'Panov-Botvinnik attack',
    'Gurgenidze counter-attack' => 'Gurgenidze system',
    'Labourdonnais-Loewenthal variation' => 'Labourdonnais-Loewenthal (Kalashnikov) variation',
    'Pelikan (Lasker/Sveshnikov) variation' => 'Sveshnikov variation',
    'Scheveningen, classical main line' => 'Scheveningen, classical',
    'French Defense: Steinitz Variation/ Boleslavsky Variation' => 'Steinitz, Boleslavsky variation',
    "Grob, Fritz gambit" => "Fritz gambit",
    "Caro-Kann Defense: Classical Variation" => "Classical Variation",
    "Caro-Kann Defense: Tartakower Variation" => "Tartakower Variation",
    "Nescafe frappe attack" => "Nescafe Frappe attack",
    "Mokele mbembe (buecker) variation" => "Mokele Mbembe (Buecker) variation",
    "Budapest/Alekhine, Abonyi variation" => "Alekhine, Abonyi variation",
    "Saemisch, main line" => "Saemisch variation",
    "Dutch variation, main line" => "Dutch variation",
  }.freeze
  IRREGULAR_NAMES = {
    'Benko gambit accepted' => 'Benko gambit',
    "Alekhine Defense: Modern Variation" => "Alekhine Defense",
    'Benko gambit half accepted' => 'Benko gambit',
    "Benko's opening, reversed Alekhine" => "Benko's opening",
    'Mujannah opening' => "Bird's opening",
    'Bird, From gambit' => "Bird's opening",
    'Bird, From gambit, Lasker variation' => "Bird's opening",
    'Bird, From gambit, Lipke variation' => "Bird's opening",
    'Bird, Hobbs gambit' => "Bird's opening",
    'Boden-Kieseritsky gambit' => 'Vienna',
    'Blumenfeld counter-gambit accepted' => 'Blumenfeld counter-gambit',
    'Budapest defence declined' => 'Budapest gambit',
    'Budapest' => 'Budapest gambit',
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
    'Evans counter-gambit' => 'Evans gambit',
    'French Defense: Steinitz Variation' => 'French',
    'Four Knights Game: Gunsberg Variation' => 'Four knights',
    'Four Knights Game: Spanish Variation' => 'Four knights',
    "Grob, Fritz gambit" => "Grob's attack",
    'Gruenfeld with e3 & Qb3' => 'Gruenfeld defence',
    'Gruenfeld with e3 Bd3' => 'Gruenfeld defence',
    'Gruenfeld with Bf4 e3' => 'Gruenfeld defence',
    "King's Indian with e4 & g3" => "King's Indian",
    'Woozle defence' => 'Old Benoni',
    'Hawk (Habichd) defence' => 'Old Benoni',
    'Petrov three knights game' => 'Petrov',
    'Ponziani counter-gambit' => 'Ponziani',
    'Polish defence' => "Queen's pawn game",
    'Kevitz-Trajkovich defence' => "Queen's Indian",
    "Queen's Indian accelerated" => "Queen's Indian",
    'QGD Slav accepted' => 'QGD Slav',
    'Reti v Dutch' => 'Reti',
    'Reti accepted' => 'Reti',
    'Norwegian defence' => 'Modern defence',
    'Pterodactyl defence' => 'Modern defence',
    "Queen's Gambit Declined Slav defence" => "Queen's Gambit Declined",
    'QGD Slav defence' => "Queen's Gambit Declined Slav",
    "Semi-Slav Defense: Accelerated Move Order" => "Queen's Gambit Declined semi-Slav",
    'Scandinavian gambit' => 'Scandinavian',
    'Scotch gambit' => 'Scotch',
    'Tayler opening' => 'Scotch',
    'Sicilian Defense: Canal-Sokolsky Attack' => 'Sicilian',
    'Scandinavian Defense: Mieses-Kotroc Variation' => 'Scandinavian',
    'Sicilian Defense: Alapin Variation' => 'Sicilian Defense',
  }.freeze

  has_many :games, foreign_key: :opening_id, dependent: :destroy

  validates :ecocode, format: { with: /\A[A-Z]\d{2}\z/ }
  # Try not to allow openings with just an ECO Code
  validates_presence_of :name

  @@openings = ChessOpenings.new

  class << self
    def find_opening ecocode, name, variation, raw_pgn
      if name&.include?(',') && variation.blank? && (name&.include?('variation') || name&.exclude?(')'))
        split_name = name.split(',')
        name = split_name.first
        variation = split_name[1..].join(',')
      end
      if IRREGULAR_NAMES.key?(name)
        if variation.blank?
          name, variation = IRREGULAR_NAMES.fetch(name), name
        else
          name, variation = IRREGULAR_NAMES.fetch(name), "#{name}/#{variation}"
        end
      end
      name = OPENING_ALIASES.fetch(name, name)
      variation = VARIATION_ALIASES.fetch(variation, variation)
      if name.blank? || variation.blank?
        first_move_line = raw_pgn.split("\n").detect { |x| x.starts_with? "1." }
        logger.info "Finding opening from #{first_move_line}"
        chess_opening = @@openings.from_string(first_move_line)
        logger.info "Opening #{chess_opening}"
        if chess_opening.name.include?(", ") && chess_opening.name.exclude?("(")
          names = chess_opening.name.split(", ")
          ChessOpening.find_or_create_by! name: names[0], variation: names[1..].join(", ") do |co|
            co.ecocode = chess_opening.eco_code
          end
        else
          ChessOpening.find_or_create_by! name: chess_opening.name, variation: "Unknown" do |co|
            co.ecocode = ecocode
          end
        end
      else
        ChessOpening.find_or_create_by! name: name.gsub(', ', ','), variation: variation.gsub("`", "'") do |co|
          co.ecocode = ecocode
        end
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
