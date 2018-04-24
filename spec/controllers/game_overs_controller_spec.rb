require 'rails_helper'

describe GameOversController, type: :controller do
  context 'PATCH#update' do
    let(:game)    { create(:game) }
    let(:season)  { game.season }
    let(:league)  { season.league }
    let(:admin)   { league.creator }

    let!(:players) { create_list(:player, 2, game: game, finishing_time: Time.now) }

    let(:params) {
      {
        league_id: league.id,
        season_id: season.id,
        game_id: game.id
      }
    }

    before { sign_in(admin) }

    it 'unfinishes all players & uncompletes the game - uncomplete true' do
      game.update(completed: true)

      patch :update, params: params.merge(uncomplete: 'true')

      players.each { |pl| pl.reload }; game.reload
      expect(players.pluck(:finishing_place).any?).to be false
      expect(players.pluck(:score).any?).to be false
      expect(game.completed).to be false
      expect(response).to redirect_to league_season_game_path(league, season, game)
    end

    it 'finishes all players & completes the game - uncomplete nil' do
      game.update(completed: false)

      patch :update, params: params

      players.each { |pl| pl.reload }; game.reload

      expect(players.pluck(:finishing_place).all?).to be true
      expect(players.pluck(:score).all?).to be true
      expect(game.completed).to be true
      expect(response).to redirect_to league_season_game_path(league, season, game)
    end
  end
end
