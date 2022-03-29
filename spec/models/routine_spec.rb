require 'rails_helper'

describe Routine do
  describe 'associations' do
    subject { Routine.create!(name: 'Monday') }
    
    it { is_expected.to have_many(:exercise_routines) }

    it { is_expected.to have_many(:exercises).through(:exercise_routines) }
  end
end
