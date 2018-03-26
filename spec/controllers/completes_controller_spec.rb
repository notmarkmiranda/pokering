require 'rails_helper'

describe CompletesController, type: :controller do
  let(:season) { create(:season) }
  let(:league) { season.league }
  let(:admin)  { league.creator }

  context 'PATCH#update' do
    before do
      sign_in(admin)
    end

    it 'redirects to league show path' do
      patch :update, params: { league_id: league.id, season_id: season.id }

      expect(response).to redirect_to league_path(league)
    end
  end
end
