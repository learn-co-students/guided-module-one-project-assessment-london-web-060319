class Recipe < ActiveRecord::Base
  has_many :recipe_and_equipment
  has_many :equipment, through: :recipe_and_equipment


  def self.find_by_recipe_name(name)
    results = []
    recipe =  Recipe.select{|recipe| recipe.recipe_name == name}
     recipe.map do |recipe| 
        results << "\e[4m\e[32m#{recipe.recipe_name}\e[0m\ningredient:#{recipe.ingredient}\e[0m\ndifficulty_level:#{recipe.difficulty_level}\n\n"
     end 
    results
  end 

  
  def self.find_recipe_by_equipment(equipment_name)
    results = []
    equipment =  Equipment.find_by(name: equipment_name)
        equipment.recipes.map do |recipe|
          results << "\e[4m\e[32m#{recipe.recipe_name}\e[0m\ningredient: #{recipe.ingredient}\e[0m\ndifficulty_level: #{recipe.difficulty_level}\n\n"
        end
    results 
     
  end 



  def self.find_recipe_by_difficulty_level(difficulty_level)
    results = []
    level =  Recipe.select{|recipe| recipe.difficulty_level == difficulty_level}
        level.map do |recipe| 
          results << "\e[4m\e[32m#{recipe.recipe_name}\e[0m\ningredient: #{recipe.ingredient}\e[0m\ndifficulty_level: #{recipe.difficulty_level}\n\n"
        end 
    results
  end 



  def self.find_recipe_by_time(cooking_time)
    results = []
    time = Recipe.select{|recipe| recipe.cooking_time == cooking_time}
      time.map do |recipe|
        results << "\e[4m\e[32m#{recipe.recipe_name}\e[0m\ningredient: #{recipe.ingredient}\e[0\ndifficulty_level: #{recipe.difficulty_level}\n\n"
      end
    results 
  end 


  

end 