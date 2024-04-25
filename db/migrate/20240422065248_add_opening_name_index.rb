class AddOpeningNameIndex < ActiveRecord::Migration[6.1]
  def change
    add_index :openings, [:ecocode, :name]
  end
end
