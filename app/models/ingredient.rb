class Ingredient < ApplicationRecord
  has_many :meal_ingredients, dependent: :destroy
  has_many :meals, through: :meal_ingredients
  has_many :nutrients, through: :ingredient_nutrients

  validates :name, :calories_per_grams, presence: true
  validates :calories_per_grams, numericality: { minimum: 0 }
end
