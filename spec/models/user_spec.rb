require 'rails_helper'

describe User, type: :model do
  context 'relationships' do
    it { should have_many :leagues }
    it { should have_many :permissions }
    it { should have_many :players }
  end

  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  context 'methods' do
    context '#full_name' do
      let(:user) { create(:user) }

      it 'returns an email' do
        user.update(first_name: nil)

        expect(user.full_name).to eq(user.email)
      end

      it 'returns a first name' do
        user.update(last_name: nil)

        expect(user.full_name).to eq('Jonathan ')
      end

      it 'returns a full name' do
        expect(user.full_name).to eq('Jonathan Doe')
      end
    end
  end
end
