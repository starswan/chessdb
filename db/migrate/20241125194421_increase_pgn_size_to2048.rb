class IncreasePgnSizeTo2048 < ActiveRecord::Migration[6.1]
  def change
    change_column :games, :pgn, :string, limit: 2048
  end
end
