# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'json'
require 'open-uri'

puts "================= STARTING SEED ================="
puts "============= DESTROYING CURRENT DATA ==========="

# Calling the Active Record method #destroy_all to empty all records for each model
# Order of creation: User > Meal > Ingredient > Nutrient
Nutrient.destroy_all
Ingredient.destroy_all
Meal.destroy_all
User.destroy_all

puts "============== CREATING USERS ===============\n\n"

user = User.new(first_name: "John",
                last_name: "Doe",
                email: "test@mail.com",
                password: "123456")
user.save!

puts "Test user created!\n\n"

# Instantiating variables for further usage
api_key = ENV['SPOONACULAR_API_KEY']
number_of_recipes = rand(1..10)

puts "============== CREATING NEW MEALS ===============\n\n"
puts "Spoonacular API Key is #{api_key}"

# Example of how to make an API call using Spoonacular:
# https://api.spoonacular.com/recipes/random?number=5&apiKey=aead23e9f6544ab3887d6d39ddab52ba

# Example of how to call an image for ingredient:
# https://spoonacular.com/cdn/ingredients_{100x100|250x250|500x500}/{ingredient-image-name.jpg}

# Example of how to get information on ingredients calories and nutrition value:
# https://api.spoonacular.com/food/ingredients/{id}/information?amount={amount}&unit={unit}

recipes = JSON.parse(URI.open("https://api.spoonacular.com/recipes/random?number=#{number_of_recipes}&apiKey=#{api_key}").read, symbolize_names: true)[:recipes]

# Interating over random recipes received in the response of the API
recipes.each_with_index do |recipe, index|
  puts "\nRecipe #{index + 1} - #{recipe[:title].capitalize}\n"

  # Each recipe must return the name (title), a default image (image), the ingredients list (for each: name, measure)
  new_meal = Meal.new(name: recipe[:title],
                  time_of_consumption: Time.now - 1,
                  category: Meal::TYPE_OF_MEAL[rand(0...Meal::TYPE_OF_MEAL.count)],
                  user: User.first)
  new_meal.save!

  # Saving the ingredients from the recipe that haven't been added before to the database
  puts "========== Creating INGREDIENTS and relationship with Meal ===========\n\n"

  recipe[:extendedIngredients].each do |ingredient|
    puts "#{ingredient[:amount]}#{ingredient[:measures][:metric][:unitLong].blank? ? " " : " " + ingredient[:measures][:metric][:unitLong] + " of "}#{ingredient[:name]}"

    new_ingredient = Ingredient.new(name: ingredient[:name], calories_per_grams: 0)

    # The line of code below guarantees there will be a value for new_ingredient, even if the object above isn't saved bc of model validations
    if new_ingredient.valid?
      new_ingredient.save!
    else
      new_ingredient = Ingredient.where(name: ingredient[:name])[0]
    end

    # Adds the relationship between the ingredient and the meal it belongs to
    new_meal_ingredient = MealIngredient.new(meal: new_meal,
                                             ingredient: new_ingredient,
                                             amount: ingredient[:amount],
                                             unit: ingredient[:measures][:metric][:unitLong])
    new_meal_ingredient.save! unless new_meal_ingredient.invalid?
  end
end

puts "\n\nCreated #{Meal.count} meals succesfully!"

puts "===================== END OF SEED! ============================="
