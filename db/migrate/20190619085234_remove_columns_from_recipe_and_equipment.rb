class RemoveColumnsFromRecipeAndEquipment < ActiveRecord::Migration[5.2]
  def change
    remove_column :recipe_and_equipment, :cooking_time, :string
    remove_column :recipe_and_equipment, :instructions, :string
  end
end
