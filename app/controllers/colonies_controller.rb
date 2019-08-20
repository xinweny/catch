class ColoniesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @colonies = Colony.all
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
