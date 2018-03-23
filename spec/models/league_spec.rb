require 'rails_helper'

describe League, type: :model do
  context 'relationships' do
    it { should belong_to :creator }
    it { should have_many :seasons }
    it { should delegate_method(:creator_permissions).to(:creator).as(:permissions) }
  end

  context 'validations' do
    before { create(:league) }

    it { should validate_presence_of :user_id }
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  context 'methods'
end
