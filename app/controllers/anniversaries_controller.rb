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

	def edit
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
	    @anniversary.user_id = current_user.id
    	if @anniversary.save
    		redirect_to portrait_anniversaries_path(@portrait,@anniversary)
    	else
    		render :new
    	end
    end

	def update
    	@anniversary = Anniversary.new(anniversary_params)
    	@portrait = Portrait.find(params[:portrait_id])
	    @anniversary.portrait_id = @portrait.id
	    @anniversary.user_id = current_user.id
    	if @anniversary.update
    		redirect_to portrait_anniversaries_path(@portrait,@anniversary)
    	else
    		render :edit
    	end
    end

    def reminder
    	if pre_anniversary
    	@anniversary = Anniversary.find(params[:id])
    	@user = User.find([:user_id])
    	NotificationMailer.remind_to_user(user_id).deliver
    end

    private
		def anniversary_params
    		params.require(:anniversary).permit(:title, :memo, :portrait_id, :user_id,:date)
		end

		def pre_anniversary

		end

end