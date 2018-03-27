require 'rails_helper'

describe League, type: :model do
  context 'relationships' do
    it { should belong_to :creator }
    it { should have_many :seasons }
    it { should have_many :games }
    it { should delegate_method(:creator_permissions).to(:creator).as(:permissions) }
    it { should delegate_method(:creator_full_name).to(:creator).as(:full_name) }
  end

  context 'validations' do
    before { create(:league) }

    it { should validate_presence_of :user_id }
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  context 'methods' do
    context 'after create commits' do
      subject { league.save!; league.reload; league }
      let(:league) { build(:league) }
      context '#create_permission' do
        it 'creates a permission after saving a league' do
          expect {
            subject
          }.to change(Permission, :count).by(1)
        end
      end

      context '#create_initial_season' do
        it 'creates an initial, active, incomplete season' do
          expect {
            subject
          }.to change(Season, :count).by(1)
        end
      end
    end

    context '#active_season' do
      let(:league) { create(:league) }
      let(:first_season) { league.seasons.first }

      it 'returns the active season' do
        active_season = create(:season, league: league)

        expect(league.active_season).to eq(active_season)
        expect(league.active_season).to_not eq(first_season)
      end
    end
  end
end
