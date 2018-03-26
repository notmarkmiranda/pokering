class ActivatesController < ApplicationController
  load_and_authorize_resource :league
  load_and_authorize_resource :season, through: :league

  def update
    @season.update(active: !@season.active)
    redirect_to league_path(@league)
  end
end
