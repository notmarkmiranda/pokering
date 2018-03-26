class CompletesController < ApplicationController
  load_and_authorize_resource :league
  load_and_authorize_resource :season, through: :league

  def update
    @season.update(completed: !@season.completed)
    redirect_to league_path(@league)
  end
end
