require 'rails_helper'

describe Season, type: :model do
  context 'relationships' do
    it { should belong_to :league }
    it { should have_many :games }
    it { should have_many :players }
  end

  context 'validations' do
    it { should validate_presence_of :league_id }
  end

  context 'methods' do
    let(:season) { create(:season) }

    context 'active / complete methods' do
      it 'active & complete = true' do
        season.update(active: true, completed: true)

        expect(season.activate_button('active')).to eq('times-circle')
        expect(season.activate_button('completed')).to eq('times-circle')
        expect(season.active_text).to eq('Active')
        expect(season.active_title).to eq('Mark as Inactive')
        expect(season.completed_text).to eq('Completed')
        expect(season.completed_title).to eq('Mark as Incomplete')
      end

      it 'active & complete = false' do
        season.update(active: false, completed: false)

        expect(season.activate_button('active')).to eq('check-circle')
        expect(season.activate_button('completed')).to eq('check-circle')
        expect(season.active_text).to eq('Inactive')
        expect(season.active_title).to eq('Mark as Active')
        expect(season.completed_text).to eq('Incomplete')
        expect(season.completed_title).to eq('Mark as Complete')
      end
    end

    context '#games_count' do
      subject { season.games_count }

      it 'returns 0 for number of games' do
        expect(subject).to eq(0)
      end

      it 'returns 1 for number of games' do
        create(:game, season: season)

        expect(subject).to eq(1)
      end

      it 'returns 2 for number of games' do
        create_list(:game, 2, season: season)

        expect(subject).to eq(2)
      end
    end


    context '#number_in_order' do
      it 'returns the number in the correct order' do
        new_season = create(:season, league: season.league)

        expect(season.number_in_order).to eq(2)
        expect(new_season.number_in_order).to eq(3)
      end
    end

    context '#players_rankings' do
      subject { season.players_rankings }

      it 'returns nil with no players' do
        expect(subject).to be nil
      end

      it 'calls #rank_by_score on Player' do
        game = create(:game, season: season)
        create(:player, game: game)

        expect(Player).to receive(:rank_by_score).with(season)
        subject
      end
    end

    it '#reverse_order'

    context '#winner_full_name' do
      subject { season.winner_full_name }

      it 'returns nil' do
        expect(subject).to be nil
      end

      it 'returns the winners full name' do

      end
    end
  end
end
