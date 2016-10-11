class Message < ActiveRecord::Base
  validates :body, :destroy_option, :countdown, presence: true
  validates :countdown, numericality: true


  def create_alias
    self.url_alias = SecureRandom.hex
  end

  def to_param
    url_alias
  end
end
