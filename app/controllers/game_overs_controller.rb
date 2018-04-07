class GameOversController < ApplicationController
  load_and_authorize_resource :league
  load_and_authorize_resource :season, through: :league
  load_and_authorize_resource :game, through: :season

  def update
		if params['uncomplete'] == 'true'
      @game.unfinish_all_players
			@game.update(completed: false)
		else
      @game.finish_all_players
			@game.update(completed: true)
		end
    redirect_to league_season_game_path(@league, @season, @game)
  end
end
