class MemoriesController < ApplicationController
	def create
    portrait = Portrait.find(params[:portrait_id])
    memory = current_user.memories.new(memory_params)
    memory.portrait_id = portrait.id
    memory.save
    redirect_to portrait_path(portrait)
	end

    def edit
    end

    def update
    end

    def destroy
    end

		private
			def memory_params
    			params.require(:memory).permit(:memory,:image)
			end
end
