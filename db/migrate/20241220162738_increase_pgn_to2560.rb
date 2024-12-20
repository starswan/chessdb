class IncreasePgnTo2560 < ActiveRecord::Migration[6.1]
  def change
    change_column :games, :pgn, :string, limit: 2560
  end
end
