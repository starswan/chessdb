class AddFenToMove < ActiveRecord::Migration[5.2]
  def change
    change_table :moves do |t|
      t.string :fen, null: false
      t.index :fen
    end
  end
end
