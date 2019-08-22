class ParticipationsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @participation = Participation.new(user: current_user, event: @event)
    authorize @participation
    @participation.save
    redirect_to event_path(@event)
  end

  def destroy
    @participation = Participation.find(params[:id])
    authorize @participation
    event = @participation.event
    @participation.destroy
    redirect_to event_path(event)
  end
end
