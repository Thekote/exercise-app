require 'rails_helper'

RSpec.describe ExerciseRoutine, type: :model do
  describe 'associations' do 
    it { is_expected.to belong_to(:exercise) }
    it { is_expected.to belong_to(:routine) }
  end
end
