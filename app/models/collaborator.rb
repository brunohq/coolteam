class Collaborator < ActiveRecord::Base
  belongs_to :group
  has_many :moods
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  attr_accessible :email, :unique_token
  before_create :assign_unique_token

  def name
    email_splited = self.email.split("@")
    name = email_splited[0].split(".").map(&:capitalize).join(' ')

  end

  private

  def assign_unique_token
    self.unique_token = SecureRandom.hex(12) until unique_token?
  end

  def unique_token?
  	!unique_token.blank? && self.class.count(:conditions => {:unique_token => unique_token}) == 0
  end

end
