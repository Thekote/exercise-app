class CreateExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises do |t|
      t.string :name
      t.text :description, null: false
      t.integer :power_level, null: false

      t.timestamps
    end
  end
end
