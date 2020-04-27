class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:index,:show]

  def show
  	@user = User.find(params[:id])
  	@portraits = @user.portraits.page(params[:page])
  	@memories = Memory.all
  	@anniversaries = @user.anniversaries.page(params[:page])
  end

  def edit
  	@user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def index
  	@users = User.page(params[:page]).per(10)
  end

  def update
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
    if  @user.update(user_params)
        redirect_to user_path(@user)
    else
        redirect_to edit_user_path(@user)
    end
  end

  def following
	@title = "Following"
	@user = User.find(params[:id])
	@users = @user.following.page(params[:page]).per(10)
	render 'show_follow'
  end

  def followers
	@title = "Followers"
	@user = User.find(params[:id])
	@users = @user.followers.page(params[:page]).per(10)
	render 'show_follow'
  end

  def timelines
    @portraits = current_user.portraits.build
    @timelines  = current_user.timeline.order(created_at: :desc).page(params[:page]).per(4)
  end


	private
		def user_params
    		params.require(:user).permit(:name, :image, :password,:introduction)
		end

  #   def baria_user
  #   unless params[:id].to_i == current_user.id
  #     redirect_to user_path(current_user)  #現在のユーザー詳細に戻る
  #   end
  # end
end
