require 'rails_helper'

describe League, type: :model do
  context 'relationships' do
    it { should belong_to :creator }
  end

  context 'validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  context 'methods'
end
