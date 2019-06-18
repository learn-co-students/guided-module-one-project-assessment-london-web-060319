class recipe < ActiveRecord::Base
  has_many :recipes_and_equipments
  has_many :equipments, through: :recipes_and_equipments

end 