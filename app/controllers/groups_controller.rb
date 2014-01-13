class GroupsController < ApplicationController
	http_basic_authenticate_with :name => "getSkilled", :password => "g3tHappy", except: [:show]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find_by_title(params[:title])
    cookies.signed[:admin] = @group.id

    redirect_to collaborators_path
  end

	def new
	end

	def create
	  @group = Group.new(params[:group])
	  @group.save
	  redirect_to action: "index"
	end
end
