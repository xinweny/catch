class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  before_action :set_colony, only: %i[new create]

  def show
    @markers = [{
      lat: @event.latitude,
      lng: @event.longitude
    }]
  end

  def new
    @event = Event.new(colony: @colony)
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.colony = @colony
    authorize @event
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @event.update(event_params)
    authorize @event
    if @event.save
      respond_to do |format|
        format.js
        format.html { redirect_to event_path(@event) }
      end
    else
      respond_to do |format|
        format.js
        format.html { render 'events/show' }
      end
    end
  end

  def destroy
    colony = @event.colony
    @event.destroy
    redirect_to colony_path(colony)
  end

  private

  def event_params
    params.require(:event).permit(:title, :address, :start, :end, :description, :phase)
  end

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end

  def set_colony
    @colony = Colony.find(params[:colony_id])
  end
end
