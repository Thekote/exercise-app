require 'rails_helper'

describe Routine do
  describe 'associations' do
    subject { Routine.create!(name: 'Monday') }
    
    it { is_expected.to have_and_belong_to_many(:exercises) }
  end
end
