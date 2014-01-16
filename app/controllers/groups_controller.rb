class GroupsController < ApplicationController
	http_basic_authenticate_with :name => "getSkilled", :password => "g3tHappy", except: [:show]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find_by_title(params[:title])
    cookies.signed[:admin] = @group.id

    redirect_to :controller => 'pages', :action => 'about'
  end

  def new
  end

  def create
    @group = Group.new(params[:group])
    @group.save
    redirect_to action: "index"
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
   
    redirect_to groups_path
  end

  def notify
    @collaborators = Collaborator.all
    @count = 0

    @collaborators.each do |collaborator|
      #if user.owes_money?
        CollaboratorMailer.daily_email(collaborator).deliver 
        @count += 1
      #end
    end
  end

end
