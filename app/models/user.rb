class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :name
  validates :email, presence: true,
                    format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
end
