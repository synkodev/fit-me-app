class Nutrient < ApplicationRecord
  has_many :ingredient_nutrients, dependent: :destroy
  has_many :ingredients, through: :ingredient_nutrients

  validates :name, presence: true
end
