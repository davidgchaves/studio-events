class RegistrationsController < ApplicationController
  def index
    @event = Event.find params[:event_id]
    @registrations = @event.registrations
  end

  def new
    @event = Event.find params[:event_id]
    @registration = @event.registrations.new
  end
end
