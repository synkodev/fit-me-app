class Nutrient < ApplicationRecord
  belongs_to :ingredient, through: :ingredient_nutrients

  validates :name, presence: true
end
