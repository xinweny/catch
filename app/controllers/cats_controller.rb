class CatsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_cat, only: %i[show edit update destroy]
  before_action :set_paper_trail_whodunnit, only: %i[create update destroy]

  def index
    @cats = policy_scope(Cat).where(colony: params[:colony_id])
  end

  def show
  end

  def new
    @cat = params[:colony_id] ? Cat.new(colony: Colony.find(params[:colony_id])) : Cat.new
    authorize @cat
  end

  def create
    @cat = Cat.new(cat_params)
    authorize @cat
    if @cat.save
      redirect_to cat_path(@cat)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @cat.update(cat_params)
    authorize @cat
    if @cat.save
      if params[:event_id]
        redirect_to event_path(params[:event_id])
      else
        redirect_to cat_path(@cat)
      end
    else
      render :edit
    end
  end

  def destroy
    colony = @cat.colony
    @cat.destroy
    redirect_to colony_path(colony)
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :description, :sex, :age, :photo, :health, :microchip_id, :status, :longitude, :latitude, :address, :colony_id)
  end

  def set_cat
    @cat = Cat.find(params[:id])
    authorize @cat
  end
end
