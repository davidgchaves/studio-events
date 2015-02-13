class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :name
  validates :email, presence: true,
                    format: Email::FORMAT_REGEX,
                    uniqueness: { case_sensitive: false }
end
