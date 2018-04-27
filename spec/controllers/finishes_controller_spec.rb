require 'rails_helper'

describe FinishesController, type: :controller do
  let(:player) { create(:player, finishing_time: nil) }
  let(:game)   { player.game }
  let(:season) { game.season }
  let(:league) { season.league }
  let(:admin)  { league.creator }
  let(:params) {
    {
      league_id: league.id,
      season_id: season.id,
      game_id: game.id,
      player_id: player.id
    }
  }

  context 'PATCH#update' do
    before { sign_in(admin) }

    it 'it updates with time set to nil - params unfinish true' do
      player.update(finishing_time: Time.now)

      patch :update, params: params.merge(unfinish: 'true')

      expect(player.reload.finishing_time).to be nil
      expect(response).to redirect_to league_season_game_path(league, season, game)
    end

    it 'it updates with time set to now - params unfinish nil' do
      time = Time.new(2015, 5, 9, 17, 30, 00)
      travel_to time do
        patch :update, params: params

        expect(player.reload.finishing_time).to eq(time)
        expect(response).to redirect_to league_season_game_path(league, season, game)
      end
    end
  end
end
