class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find params[:id]
  end

  def new
    @event = Event.new
  end

  def create
    redirect_to event_path(Event.create)
  end

  def edit
    @event = Event.find params[:id]
  end

  def update
    @event = Event.find params[:id]
    @event.update event_params
    redirect_to @event
  end

  private
    def event_params
      params.require(:event).permit(:name, :description, :location, :price, :starts_at)
    end
end
