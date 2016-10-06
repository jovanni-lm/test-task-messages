class Message < ActiveRecord::Base
  validates :body, :destroy_option, :countdown, presence: true
  validates :countdown, numericality: true
end
