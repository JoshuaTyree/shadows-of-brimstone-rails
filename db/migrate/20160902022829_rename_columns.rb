class RenameColumns < ActiveRecord::Migration[5.0]
  def change
    rename_column :characters, :min_range_hit, :range_to_hit
    rename_column :characters, :min_melee_hit, :melee_to_hit
    rename_column :characters, :min_defense, :defense
    rename_column :characters, :min_willpower, :willpower
    add_column :characters, :corruption, :integer, :default => 0
  end
end
