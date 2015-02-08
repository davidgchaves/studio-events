class Registration < ActiveRecord::Base
  belongs_to :event

  validates :name, presence: true
  validates :email, format: {
    with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
end
