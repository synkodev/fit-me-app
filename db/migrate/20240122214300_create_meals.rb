class CreateMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :meals do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.datetime :time_of_consumption
      t.string :type

      t.timestamps
    end
  end
end
