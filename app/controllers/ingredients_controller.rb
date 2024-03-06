class IngredientsController < ApplicationController
  def index
    @meal = Meal.find(params[:meal_id])
    @ingredients = @meal.ingredients
  end
end
