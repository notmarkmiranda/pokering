require 'rails_helper'

RSpec.describe Season, type: :model do
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

    context '#number_in_order' do
      it 'returns the number in the correct order' do
        new_season = create(:season, league: season.league)

        expect(season.number_in_order).to eq(2)
        expect(new_season.number_in_order).to eq(3)
      end
    end

    context '#player_rankings' do
      it 'calls #rank_by_score on Player' do
        expect(Player).to receive(:rank_by_score).with(season)
        season.players_rankings
      end
    end

    it '#reverse_order'
  end
end
