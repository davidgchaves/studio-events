module EventsHelper
  def format_price(event)
    event.free? ? content_tag(:strong, "Free") : number_to_currency(event.price)
  end
end
