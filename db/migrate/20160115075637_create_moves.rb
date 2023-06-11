#
# $Id$
#
class CreateMoves < ActiveRecord::Migration[4.2]
  def change
    create_table :moves do |t|
      t.integer :game_id, null: false
      t.integer :number, null: false
      t.boolean :white, null: false

      # This is the original PGN move
      t.string  :move, null: false, limit: 7
      # Thsse 3 are filled in dynamically
      t.string :from, null: false, limit: 2
      t.string :to, null: false, limit: 2
      # pawn promotion means this needs to be filled in
      t.string :piece, null: false, limit: 1
      #t.string  :fen, null: false
      t.index :game_id
    end
  end
end
