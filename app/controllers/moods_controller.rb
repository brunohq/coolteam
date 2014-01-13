class MoodsController < ApplicationController

  def create
    @collaborator = Collaborator.find(params[:collaborator_id])
    @mood = Mood.where(:date=>Date.today).where(:collaborator_id=>params[:collaborator_id]).first

	if @mood
	  @mood.rating = params[:mood][:rating]
	  @mood.comment = params[:mood][:comment]
	  @mood.save
	else
      @mood = @collaborator.moods.new(params[:mood])
      @mood.date = Date.today
	  @mood.save
	end

    redirect_to report_collaborators_path
  end

end
