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
    @event = Event.create event_params
    redirect_to @event
  end

  def edit
    @event = Event.find params[:id]
  end

  def update
    @event = Event.find params[:id]
    @event.update event_params
    redirect_to @event
  end

  def destroy
    @event = Event.find params[:id]
    @event.destroy
    redirect_to events_url
  end

  private
    def event_params
      params.require(:event).permit(:name, :description, :location, :price, :starts_at)
    end
end
