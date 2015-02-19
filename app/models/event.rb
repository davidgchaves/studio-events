class Event < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :location
  validates_length_of :description, minimum: 25
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates_numericality_of :capacity, greater_than: 0, only_integer: true
  validates_format_of :image_file_name,
    with: /\w+\.(gif|jpg|png)\z/i,
    message: "must reference a GIF, JPG or PNG image",
    allow_blank: true

  has_many :registrations, dependent: :destroy

  def free?
    price.blank? || price.zero?
  end

  def self.upcoming
    where("starts_at >= ?", Time.now).order "starts_at"
  end

  def spots_left
    capacity - number_of_registrations
  end

  def sold_out?
    spots_left.zero?
  end

  private
    def number_of_registrations
      registrations.size
    end
end
