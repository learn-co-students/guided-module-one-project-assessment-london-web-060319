class equipment < ActiveRecord::Base
  has_many :recipes_and_equipments
  has_many :recipes, through: :recipes_and_equipments
end
