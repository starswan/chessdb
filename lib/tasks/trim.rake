desc "trim player names"
task trim_players: :environment do
  Player.where.not(black_games_count: 0, white_games_count: 0).find_each do |p|
  # Player.find_each do |p|
    Player.where(last_name: p.last_name.strip, first_name: p.first_name.strip).where.not(id: p.id).each do |dup|
      p.white_games.each { |wg| wg.update!(white: dup) }
      p.black_games.each { |bg| bg.update!(black: dup) }
    end
  end
end

