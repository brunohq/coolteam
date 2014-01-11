class Mood < ActiveRecord::Base
  belongs_to :collaborator
  attr_accessible :comment, :date, :rating
end
