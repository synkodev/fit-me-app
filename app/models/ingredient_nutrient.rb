class IngredientNutrient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :nutrient

  validates :nutrient, uniqueness: { scope: :ingredient }
end
