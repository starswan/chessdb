class FirstNameOptional < ActiveRecord::Migration[5.2]
  def change
    change_column_null :players, :first_name, true
  end
end
