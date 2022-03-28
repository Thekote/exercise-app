class Exercise < ApplicationRecord
  validates :description, presence: true
  validates :power_level, presence: true, inclusion: { in: 0..10 }

  has_and_belongs_to_many :routines 
end
