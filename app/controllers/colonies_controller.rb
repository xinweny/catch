class ColoniesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_colony, only: %i[show]

  def index
    @colonies = policy_scope(Colony)
    authorize @colonies
  end

  def show
  end

  private

  def colony_params
    params.require(:colony).permit(:name, :location, :description, :radius)
  end

  def set_colony
    @colony = Colony.find(params[:id])
    authorize @colony
  end
end
