class GamesController < ApplicationController
  load_and_authorize_resource :league
  load_and_authorize_resource :season, through: :league
  load_and_authorize_resource :game, through: :season

  def index
  end

  def show
    @player = @game.players.new
  end

  def new
  end

  def edit
  end

  def create
    check_season_id
    if @game.save
      redirect_to league_season_game_path(@league, @season, @game)
    else
      render :new
    end
  end

  def update
    if @game.update(game_params)
      redirect_to league_season_game_path(@league, @season, @game)
    else
      render :edit
    end
  end

  def destroy
    @game.destroy
    redirect_to league_season_games_path(@league, @season)
  end

  private

  def check_season_id
    if game_params['season_id'] && game_params['season_id'] != @game.season_id
      @season = Season.find(game_params['season_id'])
      @game.season_id = game_params['season_id']
    end
  end

  def game_params
    params.require(:game).permit(:season_id, :date, :completed)
  end
end
