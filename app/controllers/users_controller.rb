class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@portraits = @user.portraits.page(params[:page])
  	@portrait = Portrait.find(params[:id])
  	@memories = @portrait.memories
  	@memory = Memory.find(params[:id])
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

	private
		def user_params
    		params.require(:user).permit(:name, :image, :password)
		end
end
