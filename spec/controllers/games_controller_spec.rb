require 'rails_helper'

describe GamesController, type: :controller do
  let(:game) { create(:game) }
  let(:season) { game.season }
  let(:league) { season.league }
  let(:admin) { league.creator }

  before do
    sign_in(admin)
  end

  context 'GET#index' do
    it 'renders index template' do
      get :index, params: { league_id: league.id, season_id: season.id }

      expect(response).to render_template :index
    end
  end

  context 'GET#show' do
    it 'renders show template' do
      get :show, params: { league_id: league.id, season_id: season.id, id: game.id }

      expect(response).to render_template :show
    end
  end

  context 'GET#new' do
    it 'renders new template' do
      get :new, params: { league_id: league.id, season_id: season.id }

      expect(response).to render_template :new
    end
  end

  context 'GET#edit' do
    it 'renders edit template' do
      get :edit, params: { league_id: league.id, season_id: season.id, id: game.id }

      expect(response).to render_template :edit
    end
  end

  context 'POST#create' do
    let(:attrs) { attributes_for(:game) }
    it 'redirects to game path - successful create' do
      post :create, params: { league_id: league.id, season_id: season.id, game: attrs }

      expect(response).to redirect_to league_season_game_path(league, season, Game.last)
    end

    it 'renders new template - unsuccessful create' do
      post :create, params: { league_id: league.id, season_id: season.id, game: attrs.except(:date) }

      expect(response).to render_template :new
    end
  end

  context 'PATCH#update' do
    it 'redirects to game path - successful update' do
      patch :update, params: { league_id: league.id, season_id: season.id, id: game.id, game: { date: Date.today } }

      expect(response).to redirect_to league_season_game_path(league, season, game)
    end
    it 'renders edit template - unsuccessful update' do
      patch :update, params: { league_id: league.id, season_id: season.id, id: game.id, game: { date: '' } }

      expect(response).to render_template :edit
    end
  end

  context 'DELETE#destroy' do
    it 'redirects to games path' do
      delete :destroy, params: { league_id: league.id, season_id: season.id, id: game.id }

      expect(response).to redirect_to league_season_games_path(league, season)
    end
  end
end
