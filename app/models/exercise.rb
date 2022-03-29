class Exercise < ApplicationRecord
  validates :description, presence: true
  validates :power_level, presence: true, inclusion: { in: 0..10 }

  has_many :exercise_routines
  has_many :routines, through: :exercise_routines 
end
