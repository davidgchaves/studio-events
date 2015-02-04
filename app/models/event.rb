class Event < ActiveRecord::Base
  validates :name, presence: true

  def free?
    price.blank? || price.zero?
  end

  def self.upcoming
    where("starts_at >= ?", Time.now).order "starts_at"
  end
end
