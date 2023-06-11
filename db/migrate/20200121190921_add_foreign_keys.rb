class AddForeignKeys < ActiveRecord::Migration[5.2]
  def change
    change_table :moves do |t|
      t.foreign_key :games
    end
    add_foreign_key :games, :players, column: :white_id
    add_foreign_key :games, :players, column: :black_id
    change_table :games do |t|
      t.foreign_key :openings
    end
  end
end
