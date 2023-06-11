class RemoveWhiteFromMovesTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :moves, :white, :boolean, null: false
  end
end
