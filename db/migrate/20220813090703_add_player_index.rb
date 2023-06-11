class AddPlayerIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :players, [:first_name, :last_name]
    add_index :openings, :ecocode
  end
end
