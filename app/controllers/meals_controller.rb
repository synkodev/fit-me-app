class MealsController < ApplicationController
  before_action :set_meal, only: %i[show]

  def index
    @meals = Meal.all
  end

  def show
    # Finds the id in the DB. This is already specified in the before_action call
  end

  def new
    # Creates an empy instance to be used in a simple_form call
  end

  def create
    # Tip: use params! Creates the newly created instance in the DB
  end

  def edit
  end

  def update
    # Tip: use params!
  end

  def delete
    # Only needs the id of the instance!
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    # Method used to allow accessibility to params (params.require().permit())
  end
end

# All the action names: [index show edit create update delete new]

# Index: retrieves a listing of the model
# Show: gets the data of an specific id
# New: empty instance of the model to call a simple form
# Create: validates the data in the model and creates the new instance in DB
# Edit: instance of specific id to be called in a simple form
# Update: same as create
# Delete: needs an id/instance to delete from the DB
