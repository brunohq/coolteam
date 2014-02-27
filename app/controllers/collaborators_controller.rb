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
    cookies.signed[:collaborator] = @collaborator.id
    cookies.signed[:group] = @collaborator.group_id
    if params[:date].present?
      @date = Date.parse params[:date]
    else     
      @date = Date.today
    end

    if @date > Date.today 
      redirect_to report_collaborators_path, :flash => { :danger => "Ainda nao chegamos la\'..." }
    end 

    current_mood = Mood.where(:date => @date).where(:collaborator_id=>@collaborator.id).first
    if current_mood
      @current_mood_rating = current_mood.rating
    end
    @welcome_msg = welcome(@date.wday)
  end

	def new
	end

	def create
    if cookies.signed[:admin].present?
  	  @collaborator = Collaborator.new(params[:collaborator])
      @collaborator.group_id = cookies.signed[:admin]
  	  if @collaborator.save
    	  redirect_to action: "index"
      else
        flash[:danger] = 'O email introduzido nao e\' va\'lido'
        render 'new'
      end
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
      if params[:date].present?
        d = Date.parse(params[:date])
      else
        d = Date.today
      end

      @n_collaborators = Group.find(cookies.signed[:group]).collaborators.count
      @monday = d.at_beginning_of_week
      @friday = @monday + 4.days
      @me = Collaborator.find(cookies.signed[:collaborator])
      @my_moods = Hash.new
      @team_moods = Hash.new
      (@monday..@friday).each_with_index do |date, index| 
        @my_moods[day_of_the_week(index)] = Mood.where("collaborator_id" => cookies.signed[:collaborator]).where(:date => date)
        @team_moods[day_of_the_week(index)] = Mood.includes(:collaborator).where("collaborators.group_id" => cookies.signed[:group]).where(:date => date).group("rating").count
      end

      if (@monday..@friday).cover?(Date.today)
        @previous_week = (Date.today - 7.days).at_beginning_of_week
      else
        @previous_week = (d - 7.days).at_beginning_of_week
        @next_week = (d + 7.days).at_beginning_of_week
      end
    else
      redirect_to root_path
    end
  end


  def welcome(weekday)
    case weekday
    when 1
      "Segunda-feira, como te sentes hoje?"
    when 2
      "Terca-feira, como te sentes hoje?"
    when 3
      "Quarta-feira, como te sentes hoje?"
    when 4
      "Quinta-feira, como te sentes hoje?"
    when 5
      "Sexta-feira, como te sentes hoje?"
    else
      "Como te sentes hoje?"
    end
  end

  def day_of_the_week(index)
    case index
    when 0
      "Segunda-feira"
    when 1
      "Terca-feira"
    when 2
      "Quarta-feira"
    when 3
      "Quinta-feira"
    when 4
      "Sexta-feira"
    else
      "Ishh-feira"
    end
  end

end
