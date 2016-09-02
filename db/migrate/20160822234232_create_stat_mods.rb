class CreateStatMods < ActiveRecord::Migration[5.0]
  def change
    create_table :stat_mods do |t|

      t.string  :stat_name
      t.integer :amount
      t.references :modifiable, polymorphic: true, index: true 

      t.timestamps
    end
  end
end
