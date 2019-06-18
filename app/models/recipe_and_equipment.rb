class recipe_and_equipment < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :equipment
  
end 