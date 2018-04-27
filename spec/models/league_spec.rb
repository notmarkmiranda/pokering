require 'rails_helper'

describe League, type: :model do
  context 'relationships' do
    it { should belong_to :creator }
    it { should have_many :seasons }
    it { should have_many :games }
    it { should have_many :players }
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
    let(:league) { build(:league) }
    let(:saved_league) { league.save; league.reload; league }

    context 'after create commits' do
      subject { league.save!; league.reload; league }
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
      let(:first_season) { saved_league.seasons.first }

      it 'returns the active season' do
        active_season = create(:season, league: saved_league)

        expect(league.active_season).to eq(active_season)
        expect(league.active_season).to_not eq(first_season)
      end
    end

    context '#active_season_standings' do
      let(:season)         { instance_double(Season) }
      let(:default_season) { saved_league.active_season }

      it 'calls #player_rankings on a season passed in' do
        expect(season).to receive(:players_rankings).once

        saved_league.active_season_standings(season)
      end

      xit 'calls #player_rankings on active season when none is provided' do
        # TODO: (2018-04-27) markmiranda => WHY DOESNT THIS WORK?
        expect(default_season).to receive(:players_rankings).once

        saved_league.active_season_standings
      end
    end

  end
end
