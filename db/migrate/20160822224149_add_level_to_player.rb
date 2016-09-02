class AddLevelToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :level, :integer, default: 1
  end
end
