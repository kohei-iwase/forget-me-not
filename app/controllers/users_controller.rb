class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@portraits = @user.portraits.page(params[:page])
  	@memories = Memory.all
  	@anniversaries = Anniversary.all
  end

  def edit
  	@user = User.find(params[:id])
  end

  def index
  	@users = User.all
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def following
	@title = "Following"
	@user = User.find(params[:id])
	@users = @user.following.all
	render 'show_follow'
  end

  def followers
	@title = "Followers"
	@user = User.find(params[:id])
	@users = @user.followers.all
	render 'show_follow'
  end



	private
		def user_params
    		params.require(:user).permit(:name, :image, :password)
		end
end
