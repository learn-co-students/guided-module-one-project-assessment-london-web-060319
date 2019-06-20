class RecipeAndEquipment < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :equipment

  self.table_name = "recipe_and_equipment"

end 
