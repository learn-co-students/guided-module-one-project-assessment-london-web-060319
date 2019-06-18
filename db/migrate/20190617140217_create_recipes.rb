class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :recipe_name
      t.string :ingredient
      t.string :difficulty_level
      t.string :recipe_providers_name
   end
  end 
end
