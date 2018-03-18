require 'rails_helper'

describe User, type: :model do
  context 'relationships'
  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end
  context 'methods'
end