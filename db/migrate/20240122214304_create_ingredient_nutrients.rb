class CreateIngredientNutrients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredient_nutrients do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :nutrient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
