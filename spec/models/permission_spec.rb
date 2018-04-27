require 'rails_helper'

describe Permission, type: :model do
  context 'relationships' do
    it { should belong_to :user }
  end

  context 'validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :subject_class }
    it { should validate_presence_of :action }
  end

  context 'methods' do
    let(:league)     { create(:league) }
    let(:permission) { create(:permission, subject_id: league.id) }

    context '#resource' do
      subject { permission.resource }

      it 'returns the resource attached to the permission' do
        expect(subject).to eq(league)
      end
    end

    context '#resource_id' do
      subject { permission.resource_id }

      it 'returns the resource_id to the permission' do
        expect(subject).to eq(league.id)
      end
    end
  end
end
