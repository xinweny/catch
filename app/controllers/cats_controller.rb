class CatsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_cat, only: %i[show edit update destroy]
  before_action :set_colony, only: %i[new create]

  def index
    @cats = policy_scope(Cat)
    authorize @cats
  end

  def show
  end

  def new
    @cat = Cat.new
    @cat.colony = @colony
    authorize @cat
  end

  def create
    @cat = Cat.new(cat_params)
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :description, :sex, :age, :photo, :health, :microchip_id, :status, :longitude, :latitude)
  end

  def set_colony
    @colony = Colony.find(params[:colony_id])
    authorize @colony
  end

  def set_cat
    @cat = Cat.find(params[:id])
    authorize @cat
  end
end
