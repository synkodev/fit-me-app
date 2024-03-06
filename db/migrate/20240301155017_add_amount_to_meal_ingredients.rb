class AddAmountToMealIngredients < ActiveRecord::Migration[7.0]
  def change
    add_column :meal_ingredients, :amount, :decimal
    add_column :meal_ingredients, :unit, :string
  end
end
