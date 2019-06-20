class CommandLineInterface
  def initialize 
   @prompt = TTY::Prompt.new
  end 
  
  def find_recipe_by_name
    recipe_name = @prompt.ask('Please entre the recipe name', required: true).split.map(&:capitalize).join(' ')
      recipes = Recipe.find_by_recipe_name(recipe_name)
      if recipes.length > 0 
        puts recipes
      else 
        puts ("Recipe not found")
      end 
  end 
 
  def find_recipe_by_equipment
    equipment_name = @prompt.ask('Please select your cooking equipment', require: true).split.map(&:capitalize).join(' ')
      recipes = Recipe.find_recipe_by_equipment(equipment_name)
      if recipes.length > 0
        puts recipes
      else 
        puts ("Recipe not found")
      end 
  end 

  def find_recipe_by_difficulty_level
    difficulty_level = @prompt.ask('Please entre the difficulty level',require: true).split.map(&:capitalize).join(' ')
      recipes = Recipe.find_recipe_by_difficulty_level(difficulty_level)
      if recipes.length > 0
        puts recipes
      else 
        puts ("Recipe not found")
      end 
  
  end 

  def find_recipe_by_time
    cooking_time = @prompt.ask('Please entre cooking_time', require: true).split.map(&:downcase).join(' ')
      recipes = Recipe.find_recipe_by_time(cooking_time)
        if recipes.length > 0
          puts recipes
        else 
          puts ("Recipe not found")
        end 
  end 

 
  
    $options = {
    'Find recipe by name' => 1,
    'Find recipe by equipment' => 2,
    'Find recipe by difficulty level' => 3,
    'Find recipe by time' => 4,
    'Exit' => 0
    }


def menu
  system "clear"
    while true 
      puts "\n\n"
      input = @prompt.select("Select an option:", $options)
        case input
        when 1
          find_recipe_by_name
        when 2
          find_recipe_by_equipment
        when 3
          find_recipe_by_difficulty_level
        when 4
          find_recipe_by_time 
        when 0
      break
      end
    end
  end



end 
