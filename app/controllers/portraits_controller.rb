class PortraitsController < ApplicationController
	def new
		@portrait = Portrait.new
	end

	# ポートレイトの保存
	def create
    	@portrait = Portrait.new(portrait_params)
    	@portrait.user_id = current_user.id
    	if @portrait.save
    		redirect_to portraits_path
    	else
    		render :new
    	end
	end

	def index
		@portraits = Portrait.page(params[:page])
	end

	def show
		@portrait = Portrait.find(params[:id])
		@memory = Memory.new
	end

	def edit
	end

	def update
	end

	def destroy
		@portrait = Portrait.find(params[:id])
		@portrait.destroy
		redirect_to portraits_path
	end

	# ポートレイトのストロングパラメータ
	private
    	def portrait_params
        	params.require(:portrait).permit(:name, :image, :age)
    	end


end
