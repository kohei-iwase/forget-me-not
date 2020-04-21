class AnniversariesController < ApplicationController
	def index
		@user = current_user
		@anniversaries = Anniversary.all
	end

	def new
		@user = current_user
		@portrait = Portrait.find(params[:portrait_id])
		@anniversary = Anniversary.new
	end

	def show
		@user = current_user
		@portrait = Portrait.find(params[:portrait_id])
		@anniversary = Anniversary.find(params[:id])
	end

	def create
    	@anniversary = Anniversary.new(anniversary_params)
    	@portrait = Portrait.find(params[:portrait_id])
	    @anniversary.portrait_id = @portrait.id
	    @anniversary.user_id = @user.id
    	if @anniversary.save
    		redirect_to portrait_anniversaries_path(@portrait,@anniversary)
    	else
    		render :new
    	end
    end

    private
		def anniversary_params
    		params.require(:anniversary).permit(:title, :memo, :portrait_id, :date)
		end
end