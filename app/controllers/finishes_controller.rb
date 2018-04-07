class FinishesController < ApplicationController
  load_and_authorize_resource :league
  load_and_authorize_resource :season, through: :league
  load_and_authorize_resource :game, through: :season
  load_and_authorize_resource :player, through: :game

  def update
    if params['unfinish'] == 'true'
      @player.score_and_update
    else
      @player.score_and_update(Time.zone.now)
    end
    redirect_to league_season_game_path(@league, @season, @game)
  end
end
