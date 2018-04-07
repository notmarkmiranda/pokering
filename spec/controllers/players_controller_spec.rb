require 'rails_helper'

describe PlayersController, type: :controller do
  let(:user)   { create(:user, email: 'superduper@gmail.com') }
  let(:player) { create(:player, user: user) }
  let(:game)   { player.game }
  let(:season) { game.season }
  let(:league) { season.league }
  let(:admin)  { league.creator }

  before do
    sign_in(admin)
  end

  context 'GET#index' do
    it 'renders index template' do
      get :index, params: { league_id: league.id, season_id: season.id, game_id: game.id }

      expect(response).to render_template :index
    end
  end

  context 'GET#show' do
    it 'renders show template' do
      get :show, params: { league_id: league.id, season_id: season.id, game_id: game.id, id: player.id }

      expect(response).to render_template :show
    end
  end

  context 'GET#new' do
    it 'renders new template' do
      get :new, params: { league_id: league.id, season_id: season.id, game_id: game.id }

      expect(response).to render_template :new
    end
  end

  context 'GET#edit' do
    it 'renders edit template' do
      get :edit, params: { league_id: league.id, season_id: season.id, game_id: game.id, id: player.id }

      expect(response).to render_template :edit
    end
  end

  context 'POST#create' do
    let(:attrs) { attributes_for(:player) }

    it 'redirects to new player path' do
      post :create, params: { league_id: league.id, season_id: season.id, game_id: game.id, player: attrs }

      expect(response).to redirect_to league_season_game_path(league, season, game)
    end

    it 'commit params Just Save' do
      post :create, params: { league_id: league.id, season_id: season.id, game_id: game.id, player: attrs, commit: 'Just Save' }

      expect(response).to redirect_to league_season_game_path(league, season, game)
    end
  end

  context 'PATCH#update' do
    it 'redirects to player path - successful update' do
      patch :update, params: { league_id: league.id, season_id: season.id, game_id: game.id, id: player.id, player: { finishing_place: 2 } }

      expect(response).to redirect_to league_season_game_player_path(league, season, game, player)
    end

    it 'renders edit - unsuccessful update' do
      patch :update, params: { league_id: league.id, season_id: season.id, game_id: game.id, id: player.id, player: { user_id: '' } }

      expect(response).to render_template :edit
    end
  end

  context 'DELETE#destroy' do
    it 'redirects to new player path' do
      delete :destroy, params: { league_id: league.id, season_id: season.id, game_id: game.id, id: player.id }

      expect(response).to redirect_to league_season_game_path(league, season, game)
    end
  end
end
