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
    if params[:event_id]
      @event = Event.find(params[:event_id])
      if @cat.save
        update_event
        respond_to do |format|
          format.js
          format.html { redirect_to event_path(params[:event_id]) }
        end
      else
        respond_to do |format|
          format.js
          format.html { render 'cats/show' }
        end
      end
    else
      if @cat.save
        redirect_to cat_path(@cat)
      else
        render :edit
      end
    end
  end

  def destroy
    colony = @cat.colony
    @cat.destroy
    redirect_to colony_path(colony)
  end

  private

  def update_event
    spotted = @cat.colony.has_cats?(0)
    trapped = @cat.colony.has_cats?(1)
    at_vet = @cat.colony.has_cats?(2)
    neutered = @cat.colony.has_cats?(3)
    released = @cat.colony.has_cats?(4)

    if spotted
      @event.update(phase: 0)
    elsif trapped
      @event.update(phase: 1)
    elsif at_vet
      @event.update(phase: 1)
    elsif neutered
      @event.update(phase: 2)
    elsif released
      @event.update(phase: 5)
    end

    @event.save
  end

  def cat_params
    params.require(:cat).permit(:name, :description, :sex, :age, :photo, :health, :microchip_id, :status, :longitude, :latitude, :address, :colony_id)
  end

  def set_cat
    @cat = Cat.find(params[:id])
    authorize @cat
  end
end
