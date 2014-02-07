class MoodsController < ApplicationController

  def create
    @collaborator = Collaborator.find(params[:collaborator_id])
    @mood = Mood.where(:date => params[:mood][:date]).where(:collaborator_id=>params[:collaborator_id]).first

    unless params[:mood][:rating].blank?
		if @mood
		  @mood.rating = params[:mood][:rating]
		  @mood.comment = params[:mood][:comment]
		  @mood.save
		else
	      @mood = @collaborator.moods.new(params[:mood])
	      @mood.date = params[:mood][:date]
		  @mood.save
		end

	    redirect_to report_collaborators_path
	else		
		redirect_to login_path(@collaborator.unique_token), :flash => { :danger => "Tem de selecionar um estado antes de clicar no botao actualizar." }
	end
  end

end
