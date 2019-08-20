class EventsController < ApplicationController
  before_action :set_event, only: %i[show]

  def show
  end

  def new
  end

  def create
  end

  private

  def event_params
    params.require(:event).permit(:title, :address, :start, :end, :description, :phase)
  end

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end
end
