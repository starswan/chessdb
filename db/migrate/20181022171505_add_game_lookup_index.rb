class AddGameLookupIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :games, [:white_id, :black_id, :opening_id, :date]
  end
end
