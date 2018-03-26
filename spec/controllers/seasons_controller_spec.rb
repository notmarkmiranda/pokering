require 'rails_helper'

describe SeasonsController, type: :controller do
  let(:league) { create(:league) }
  let(:admin)  { league.creator }
  let(:season) { create(:season, league: league) }

  before do
    sign_in(admin)
  end

  context 'GET#show' do
    it 'renders show template' do
      get :show, params: { league_id: league.id, id: season.id }

      expect(response).to render_template :show
    end
  end

  context 'POST#create' do
    let(:attrs) { attributes_for(:season) }

    it 'redirects to season path - successful create' do
      post :create, params: { league_id: league.id, season: attrs }

      expect(response).to redirect_to league_path(league)
    end
  end

  context 'PATCH#update' do
    it 'redirects to season path' do
      patch :update, params: { league_id: league.id, id: season.id, season: { active: false } }

      expect(response).to redirect_to league_season_path(league, season)
    end
  end

  context 'DELETE#destroy' do
    it 'redirects to league seasons path' do
      delete :destroy, params: { league_id: league.id, id: season.id }

      expect(response).to redirect_to league_seasons_path(league)
    end
  end
end
