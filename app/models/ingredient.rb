class Ingredient < ApplicationRecord
  belongs_to :meal, through: :meal_ingredients
  has_many :nutrients, through: :ingredient_nutrients

  validates :name, :calories_per_grams, presence: true
  validates :calories_per_grams, numericality: { minimum: 0 }
end
