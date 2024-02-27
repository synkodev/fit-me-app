class MealsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_meal, only: %i[show edit update destroy]

  def index
    @meals = Meal.all
  end

  def show
    # Finds the id in the DB. This is already specified in the before_action call
  end

  def new
    # Creates an empy instance to be used in a simple_form call
    @meal = Meal.new
  end

  def create
    # Tip: use params! Creates the newly created instance in the DB
    @meal = Meal.new(meal_params)
    @meal.user = current_user

    if @meal.save
      redirect_to meal_path(@meal), notice: "Refeição cadastrada!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    # Tip: use params!
    if @meal.save
      redirect_to meal_path(@meal), notice: "Refeição atualizada."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete
    # Only needs the id of the instance!
    @meal.destroy
    redirect_to meals_path, status: :see_other
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    # Method used to allow accessibility to params (params.require().permit())
    params.require(:meal).permit(:name, :time_of_consumption, :type)
  end
end

# All the action names: [index show edit create update delete new]
# -------------------    QUICK CHEATSHEET   ---------------------------
# Index: retrieves a listing of the model
# Show: gets the data of an specific id
# New: empty instance of the model to call a simple form
# Create: validates the data in the model and creates the new instance in DB
# Edit: instance of specific id to be called in a simple form
# Update: same as create
# Delete: needs an id/instance to delete from the DB
