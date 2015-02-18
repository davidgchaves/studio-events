class Registration < ActiveRecord::Base
  belongs_to :event

  HOW_HEARD_OPTIONS = ["Newsletter", "Blog Post", "Twitter", "Web Search", "Friends/Coworker", "Other"]

  validates_presence_of :name
  validates_format_of :email, with: Email::FORMAT_REGEX
  validates :how_heard, inclusion: { in: HOW_HEARD_OPTIONS }
end
