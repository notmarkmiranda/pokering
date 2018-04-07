class PlayersController < ApplicationController
  load_and_authorize_resource :league
  load_and_authorize_resource :season, through: :league
  load_and_authorize_resource :game, through: :season
  load_and_authorize_resource :player, through: :game

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if params['commit'] == 'Just Save'
      @player.save
    else
      @player.score_and_update(Time.zone.now)
      @player.save
    end
    redirect_to league_season_game_path(@league, @season, @game)
  end

  def update
    if @player.update(player_params)
      redirect_to league_season_game_player_path(@league, @season, @game, @player)
    else
      render :edit
    end
  end

  def destroy
    @player.score_and_destroy
    redirect_to league_season_game_path(@league, @season, @game)
  end

  private

  def player_params
    params.require(:player).permit(:game_id, :user_id, :finishing_place, :score, :additional_expense)
  end
end
