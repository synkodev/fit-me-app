class Meal < ApplicationRecord
  belongs_to :user
  has_many :ingredients, through: :meal_ingredients

  TYPE_OF_MEAL = %W[Breakfast Lunch Dinner Brunch Supper Other]

  validates :name, :time_of_consumption, :type, presence: true
  validates :time_of_consumption, inclusion: { in: TYPE_OF_MEAL, message: "%{value} is not a valid meal" }
  validate :consumed_at_valid_time

  def consumed_at_valid_time
    # Checks if time informed is within the last 7 days and also if it's not after the current time
    if self.time_of_consumption < Now - 7 || self.time_of_consumption > Now
      errors.add(:time_of_consumption, 'must have been consumed in the past 7 days')
    end
  end
end
