class SplitPlayerNames < ActiveRecord::Migration[5.2]
  def up
    change_table :players do |t|
      t.string :first_name
      t.string :last_name
    end
    Player.find_each do |p|
      p.last_name, p.first_name = p.name.split(',')
      p.save!
    end
    change_column_null(:players, :first_name, false)
    change_column_null(:players, :last_name, false)
    remove_column :players, :name
  end

  def down
    change_table :players do |t|
      t.string :name
    end
    Player.find_each do |p|
      p.name = [p.last_name, p.first_name].join(',')
      p.save!
    end
    change_column_null(:players, :name, false)
    remove_column :players, :first_name
    remove_column :players, :last_name
  end
end
