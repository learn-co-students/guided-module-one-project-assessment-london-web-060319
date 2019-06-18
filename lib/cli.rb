class CommandLineInterface
  def initialize 
   @prompt = TTY::Prompt.new
  end 
  
  def greet
   puts "welcome to Recipe-App ,Please select your recipe"
  end
  
  choices = %w(choose recipe, add recipe, update recipe, delete recipe, review recipe)
  prompt.multi_select("Select what you want to do today?", choices)
  
  
end 


