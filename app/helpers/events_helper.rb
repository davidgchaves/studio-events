module EventsHelper
  def format_price(event)
    event.free? ? content_tag(:strong, "Free") : number_to_currency(event.price)
  end

  def image_for(event)
    event.image_file_name.blank? ? image_tag("placeholder.png") : image_tag(event.image_file_name)
  end
end
