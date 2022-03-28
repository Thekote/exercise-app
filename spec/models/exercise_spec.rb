require 'rails_helper'

describe Exercise do
  describe 'validations' do
    subject { Exercise.create!(name: 'pushups', description: 'imagine a nice description here', power_level: '5') }

    it { is_expected.to validate_presence_of(:description) }

    it { is_expected.to validate_presence_of(:power_level) }

    it { is_expected.to validate_inclusion_of(:power_level).in_range(0..10) }
  end

  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:routines) }
  end
end
