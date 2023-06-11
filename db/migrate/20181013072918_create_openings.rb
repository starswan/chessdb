class CreateOpenings < ActiveRecord::Migration[4.2]
  def change
    create_table :openings do |t|
      t.string :ecocode
      t.string :name
      t.string :variation

      t.timestamps null: false
    end
  end
end
