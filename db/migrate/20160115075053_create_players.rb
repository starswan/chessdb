#
# $Id$
#
class CreatePlayers < ActiveRecord::Migration[4.2]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.integer :fideid

      t.timestamps null: false
    end
  end
end
