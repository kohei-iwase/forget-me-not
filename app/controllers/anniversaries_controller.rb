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
		@anniversary = Anniversary.find(params[:portrait_id])
	end

	def create
    	@anniversary = Anniversary.new(anniversary_params)
    	@anniversary.user_id = current_user.id
	    @anniversary.portrait_id = @portrait.id
    	@anniversary.save
    	if @portrait.save
    		redirect_to portrait_path(@portrait.id)
    	else
    		render :new
    	end
    end

    private
		def aniversary_params
    		params.require(:anniversary).permit(:title, :memo, :user_id, :portrait_id, :date)
		end
end