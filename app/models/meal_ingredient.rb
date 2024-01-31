class MealIngredient < ApplicationRecord
  belongs_to :meal
  belongs_to :ingredient

  validate :ingredient, uniqueness: { scope: :meal }
end
