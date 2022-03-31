class Routine < ApplicationRecord
  has_many :exercise_routines, dependent: :delete_all
  has_many :exercises, through: :exercise_routines  
end
