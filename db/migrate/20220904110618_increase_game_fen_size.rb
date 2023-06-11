class IncreaseGameFenSize < ActiveRecord::Migration[5.2]
  def change
    change_column :games, :pgn, :string, limit: 1536
  end
end
