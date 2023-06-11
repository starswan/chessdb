#
# $Id$
#
class CreateGames < ActiveRecord::Migration[4.2]
  def change
    create_table :games do |t|
      t.integer :white_id, null: false
      t.integer :black_id, null: false
      t.date :date, null: false
      t.references :opening, null: false
      t.string :result, null: false

      t.timestamps null: false
    end
  end
end
