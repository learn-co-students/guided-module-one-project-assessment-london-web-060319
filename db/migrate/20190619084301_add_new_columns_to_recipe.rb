class AddNewColumnsToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :cooking_time, :string
    add_column :recipes, :instructions, :string
  end
end
