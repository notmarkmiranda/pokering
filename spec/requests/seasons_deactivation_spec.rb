require 'rails_helper'

describe 'Seasons Deactivation', type: :request do
  let(:league)       { create(:league) }
  let(:admin)        { league.creator }
  let(:first_season) { league.seasons.first }

  before do
    sign_in(admin)
  end

  context 'on create' do


    it 'deactivates the other season' do
      post "/leagues/#{league.id}/seasons", params: { season: { league_id: league.id } }

      expect(first_season.reload.active).to be (false)
    end
  end

  context 'on update' do
    before do
      @seasons = create_list(:season, 5, league: league, active: false)
    end

    it 'deactivates other seasons on update of one season' do
      patch "/leagues/#{league.id}/seasons/#{@seasons.last.id}/activate"

      expect(first_season.reload.active).to be false
      expect(@seasons.first.reload.active).to be false
      expect(@seasons.last.reload.active).to be true
    end
  end
end
