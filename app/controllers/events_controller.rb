class EventsController < ApplicationController
  before_action :set_event, only: %i[show]
  before_action :set_colony, only: %i[new create]

  def show
  end

  def new
    @event = Event.new(colony: @colony)
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    authorize @event
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
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
