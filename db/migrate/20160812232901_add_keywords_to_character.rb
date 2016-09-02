class AddKeywordsToCharacter < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :keywords, :string
  end
end
