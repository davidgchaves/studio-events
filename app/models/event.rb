class Event < ActiveRecord::Base
  validates :name, :location, presence: true
  validates :description, length: { minimum: 25 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }

  def free?
    price.blank? || price.zero?
  end

  def self.upcoming
    where("starts_at >= ?", Time.now).order "starts_at"
  end
end
