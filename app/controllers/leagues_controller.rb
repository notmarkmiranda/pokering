class LeaguesController < ApplicationController
  load_and_authorize_resource :league, through: :current_user, except: [:show]

  def index
  end

  def show
    @league = League.find(params[:id])
  end

  def new
  end

  def edit
  end

  def create
    if @league.save
      redirect_to @league
    else
      render :new
    end
  end

  def update
    if @league.update(league_params)
      redirect_to @league
    else
      render :edit
    end
  end

  def destroy
    @league.destroy
    redirect_to leagues_path
  end

  private

  def league_params
    params.require(:league).permit(:user_id, :name)
  end
end
