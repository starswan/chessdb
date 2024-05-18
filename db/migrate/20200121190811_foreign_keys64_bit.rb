class ForeignKeys64Bit < ActiveRecord::Migration[5.2]
  TABLES = [:games, :moves, :openings, :players].freeze
  def up
    TABLES.each do |table|
      change_column table, :id, :bigint, unique: true, null: false, auto_increment: true
    end
    change_column :moves, :game_id, :bigint
    change_column :games, :white_id, :bigint
    change_column :games, :black_id, :bigint
    change_column :games, :opening_id, :bigint
  end

  def down
    TABLES.each do |table|
      change_column table, :id, :integer
    end
    change_column :moves, :game_id, :integer
    change_column :games, :white_id, :integer
    change_column :games, :black_id, :integer
    change_column :games, :opening_id, :integer
  end
end
