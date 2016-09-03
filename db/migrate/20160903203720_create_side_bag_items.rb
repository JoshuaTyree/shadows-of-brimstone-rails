class CreateSideBagItems < ActiveRecord::Migration[5.0]
  def change
    create_table :side_bag_items do |t|
      t.references :player, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
