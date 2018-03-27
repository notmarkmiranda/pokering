class SeasonsController < ApplicationController
  load_and_authorize_resource :league
  load_and_authorize_resource :season, through: :league

  def show
  end

  def create
    @season.save
    redirect_to league_path(@league)
  end

  def update
    @season.update(season_params)
    redirect_to league_season_path(@league, @season)
  end

  def destroy
    @season.destroy
    redirect_to league_seasons_path(@league)
  end

  private

  def season_params
    params.require(:season).permit(:league_id, :active, :completed)
  end
end
