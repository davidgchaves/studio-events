class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find params[:id]
  end

  def edit
    @event = Event.find params[:id]
  end

  def update
    redirect_to event_path
  end
end
