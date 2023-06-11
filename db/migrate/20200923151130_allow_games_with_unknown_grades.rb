class AllowGamesWithUnknownGrades < ActiveRecord::Migration[5.2]
  def change
    change_column_null :games, :white_elo, true
    change_column_null :games, :black_elo, true
  end
end
