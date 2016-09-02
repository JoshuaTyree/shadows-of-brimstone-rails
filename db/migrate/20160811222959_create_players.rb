class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.references :character, index: true
      t.references :starting_ability, index: true
      t.string  :name
      t.integer :xp, default: 0
      t.integer :money, default: 0
      t.integer :wounds, default: 0
      t.integer :horror_wounds, default: 0
      t.timestamps
    end
  end
end
