class RecipesAndEquipments < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes_and_equipments do |t|
      t.integer :cooking_time
      t.string :instructions
      t.integer :equipment_id
      t.integer :recipe_id
    end 

  end
end
