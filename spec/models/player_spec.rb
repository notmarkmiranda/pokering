require 'rails_helper'

describe Player, type: :model do
  context 'relationships' do
    it { should belong_to :game }
    it { should belong_to :user }
    it { should delegate_method(:season).to(:game) }
  end

  context 'validations' do
    it { should validate_presence_of :game_id }
    it { should validate_presence_of :user_id }
    it do
      user = create(:user, email: 'asdf@gmail.com')
      create(:player, user: user)

      should validate_uniqueness_of(:user_id).scoped_to(:game_id)
    end
  end
  context 'methods'
end
