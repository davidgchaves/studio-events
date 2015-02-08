class Registration < ActiveRecord::Base
  belongs_to :event

  HOW_HEARD_OPTIONS = ["Newsletter", "Blog Post", "Twitter", "Web Search", "Friends/Coworker", "Other"]

  validates :name, presence: true
  validates :email, format: {
    with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :how_heard, inclusion: { in: HOW_HEARD_OPTIONS }
end
