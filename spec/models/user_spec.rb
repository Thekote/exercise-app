require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(email: 'user@usermail.com', password: 'qwerty1234') }

  describe 'validations' do 
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end
end
