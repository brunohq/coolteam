class CollaboratorsController < ApplicationController

  def index
    if cookies.signed[:admin].present?
      @collaborators = Group.find(cookies.signed[:admin]).collaborators
    else
      redirect_to root_path
    end
  end

  def show
    @collaborator = Collaborator.find_by_unique_token(params[:unique_token])
    cookies.signed[:group] = @collaborator.group_id
    @today = Date.today
    @welcome_msg = welcome(@today.wday)
  end

	def new
	end

	def create
    if cookies.signed[:admin].present?
  	  @collaborator = Collaborator.new(params[:collaborator])
      @collaborator.group_id = cookies.signed[:admin]
  	  @collaborator.save
  	  redirect_to action: "index"
    else
      redirect_to root_path
    end
	end

  def edit
    if cookies.signed[:admin].present?
      @collaborator = Collaborator.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def change_email
    if cookies.signed[:admin].present?
      @collaborator = Collaborator.find(params[:id])
      @collaborator.email = params[:collaborator][:email]

      if @collaborator.save
        redirect_to collaborators_path
      else
        render 'edit'
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    @collaborator.destroy
   
    redirect_to collaborators_path
  end

  def report
    if cookies.signed[:group].present?
      d = Date.today
      @monday = d.at_beginning_of_week
      @friday = @monday + 4.days
      @moods = Hash.new
      (@monday..@friday).each do |date| 
        @moods[date.strftime('%A') ] = Mood.includes(:collaborator).where("collaborators.group_id" => cookies.signed[:group]).where(:date => date)
      end
    else
      redirect_to root_path
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
