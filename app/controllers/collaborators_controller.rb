class CollaboratorsController < ApplicationController

  def index
    @collaborators = Collaborator.all
  end

  def show
    @collaborator = Collaborator.find_by_unique_token(params[:unique_token])
    session[:group] = @collaborator.unique_token
    @today = Date.today
    @welcome_msg = welcome(@today.wday)
  end

	def new
	end

	def create
	  @collaborator = Collaborator.new(params[:collaborator])
	  @collaborator.save
	  redirect_to action: "index"
	end

  def report
    @moods = Mood.all
    @collaborator = session[:group]
  end


  def welcome(weekday)
    case weekday
    when 1
      "Segunda-feira, Como te sentes hoje?"
    when 2
      "Terca-feira, Como te sentes hoje?"
    when 3
      "Quarta-feira, Como te sentes hoje?"
    when 4
      "Quinta-feira, Como te sentes hoje?"
    when 5
      "Sexta-feira, Como te sentes hoje?"
    else
      "Como te sentes hoje?"
    end
  end

end
