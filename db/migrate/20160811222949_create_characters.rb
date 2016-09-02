class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string  :name
      t.integer :combat
      t.integer :max_grit
      t.integer :min_range_hit
      t.integer :min_melee_hit
      t.integer :health
      t.integer :min_defense
      t.integer :sanity
      t.integer :min_willpower
      t.integer :agility
      t.integer :cunning
      t.integer :spirit
      t.integer :strength
      t.integer :lore
      t.integer :luck
      t.integer :initiative
      t.timestamps
    end
  end
end
