class Group < ActiveRecord::Base
  has_many :collaborators
  attr_accessible :title

  def inactive_collaborators_count
  	collaborators = self.collaborators
  	n_inactive = 0
  	monday = Date.today.at_beginning_of_week
    friday = monday + 4.days
  	collaborators.each do |c|
  	  n_inactive += 1 unless (c.moods.where(:date => monday..friday).count > 0)
  	end
  	n_inactive
  end

  def total_collaborators_count
  	self.collaborators.count
  end

  def missed_moods_count
  	monday = Date.today.at_beginning_of_week
    friday = monday + 4.days
  	completed_moods = Mood.includes(:collaborator).where("collaborators.group_id" => self.id).where(:date => monday..friday).count
  	self.total_moods_count - completed_moods
  end

  def total_moods_count
  	self.collaborators.count * Date.today.wday
  end
end
