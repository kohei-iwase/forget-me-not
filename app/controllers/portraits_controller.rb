class PortraitsController < ApplicationController
	def new
		@portrait = Portrait.new
	end

	# アルバムの保存
	def create
    	@portrait = Portrait.new(portrait_params)
    	@portrait.user_id = current_user.id
    	if @portrait.save
    		redirect_to edit_portrait_path(@portrait.id)
    	else
    		redirect_to new_portrait_path
    	end
	end

	def index
		@portraits = Portrait.all
		@memrories = Memory.all

	end

	def show
		@user = current_user
		@portrait = Portrait.find(params[:id])
		@memrories = @portrait.memories.all
		@memory = Memory.new
	end

	def edit
		@portrait = Portrait.find(params[:id])

		#正規ユーザー以外の編集を認めない
		if @portrait.user != current_user
        redirect_to portraits_path
      end
	end

	def update
		@portrait = Portrait.find(params[:id])

    	if @portrait.update(portrait_params)
	    	redirect_to portrait_path(@portrait)
		else
			redirect_to edit_portrait_path(@portrait)
		end
	end

	def destroy
		@portrait = Portrait.find(params[:id])
		@portrait.destroy
		redirect_to portraits_path
	end

	# ポートレイトのストロングパラメータ
	private
    	def portrait_params
        	params.require(:portrait).permit(:name, :image, :age, :gender, :species, :date_of_birth,:anniversary,
        								:likes_and_dislikes,:interest,:specialty,:family,:personality,:found,
        								:more_about_me)
    	end

end
