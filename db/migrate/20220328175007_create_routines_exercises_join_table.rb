class CreateRoutinesExercisesJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises_routines, id: false do |t|
      t.belongs_to :exercise, foreign_key: true
      t.belongs_to :routine, foreign_key: true
    end
  end
end
