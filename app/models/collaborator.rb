class Collaborator < ActiveRecord::Base
  has_many :moods
  attr_accessible :email, :unique_token
  before_create :assign_unique_token

  private

  def assign_unique_token
    self.unique_token = SecureRandom.hex(12) until unique_token?
  end

  def unique_token?
  	!unique_token.blank? && self.class.count(:conditions => {:unique_token => unique_token}) == 0
  end

end
