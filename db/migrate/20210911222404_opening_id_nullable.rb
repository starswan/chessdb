class OpeningIdNullable < ActiveRecord::Migration[5.2]
  def up
    change_column_null :games, :opening_id, true
  end

  def down
    change_column_null :games, :opening_id, false
  end
end
