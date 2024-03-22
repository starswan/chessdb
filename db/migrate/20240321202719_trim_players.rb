class TrimPlayers < ActiveRecord::Migration[6.1]
  def change
    # Player.where.not(black_games_count: 0, white_games_count: 0).find_each do |p|
    Player.find_each do |p|
      if p.white_games_count.zero? && p.black_games_count.zero?
        p.destroy!
      else
        Player.where(last_name: p.last_name.strip, first_name: p.first_name.strip)
              .where.not(id: p.id).where.not(black_games_count: 0, white_games_count: 0)
              .each do |dup|
          say_with_time "Trimming #{dup.id} [#{dup.first_name}] [#{dup.last_name}] to belong to #{p.id} [#{p.first_name}] [#{p.last_name}]" do
            dup.white_games.each { |wg| wg.update!(white: p) }
            dup.black_games.each { |bg| bg.update!(black: p) }
            dup.destroy!
          end
        end
      end
    end
  end
end
