class AddCorruptionToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :corruption, :integer, default: 0
  end
end
