class AddEquippedToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :equipped, :boolean, default: false
  end
end
