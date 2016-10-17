
class Message < ActiveRecord::Base
  validates :body, :destroy_option, :countdown, :password, presence: true
  validates :countdown, numericality: true
  before_save :set_expiration_time, :create_alias

  def create_alias
    self.url_alias = SecureRandom.hex
  end

  def to_param
    url_alias
  end

  def self.delete_expired
    where('expiration_time < ?', Time.now.to_i).delete_all
  end

  def set_expiration_time
    if destroy_option == 'hours'
      self.expiration_time = Time.now.to_i + countdown.hour.to_i
    end
  end
end
