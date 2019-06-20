class CreateRecipeAndEquipment < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_and_equipment do |t|
      t.integer :cooking_time
      t.string :instructions
      t.integer :equipment_id
      t.integer :recipe_id
    end 

  end
end
