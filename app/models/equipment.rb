class Equipment < ActiveRecord::Base
  has_many :recipe_and_equipment
  has_many :recipes, through: :recipe_and_equipment
end
