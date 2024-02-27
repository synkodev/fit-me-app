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

Nutrient.destroy_all
Ingredient.destroy_all
Meal.destroy_all

api_key = ENV['SPOONACULAR_API_KEY'];
number_of_recipes = rand(1..10)

puts "============== CREATING NEW MEALS ==============="
puts "Spoonacular API Key is #{api_key}"

# Example of how to make an API call using Spoonacular:
# https://api.spoonacular.com/recipes/random?number=5&apiKey=aead23e9f6544ab3887d6d39ddab52ba

recipes = JSON.parse(URI.open("https://api.spoonacular.com/recipes/random?number=#{number_of_recipes}&apiKey=#{api_key}").read, symbolize_names: true)[:recipes]

recipes.each do |recipe|
  puts recipe[:title]
end
