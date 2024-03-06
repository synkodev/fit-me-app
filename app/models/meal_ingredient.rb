class MealIngredient < ApplicationRecord
  belongs_to :meal
  belongs_to :ingredient

  validates :ingredient, uniqueness: { scope: :meal }
  validates :amount, numericality: { greater_than: 0 }
end
