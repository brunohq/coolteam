class CollaboratorsController < ApplicationController

  def index
    @collaborators = Group.find(session[:group_admin]).collaborators
  end

  def show
    @collaborator = Collaborator.find_by_unique_token(params[:unique_token])
    session[:group] = @collaborator.group_id
    @today = Date.today
    @welcome_msg = welcome(@today.wday)
  end

	def new
	end

	def create
	  @collaborator = Collaborator.new(params[:collaborator])
    @collaborator.group_id = session[:group]
	  @collaborator.save
	  redirect_to action: "index"
	end

  def edit
    @collaborator = Collaborator.find(params[:id])
  end

  def change_email
    @collaborator = Collaborator.find(params[:id])
    @collaborator.email = params[:collaborator][:email]

    if @collaborator.save
      redirect_to collaborators_path
    else
      render 'edit'
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    @collaborator.destroy
   
    redirect_to collaborators_path
  end

  def report
    cols = Group.find(session[:group]).collaborators
    cols.each do |c|
      @moods << c.moods
    end
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
