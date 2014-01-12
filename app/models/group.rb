class Group < ActiveRecord::Base
  has_many :collaborators
  attr_accessible :title
end
