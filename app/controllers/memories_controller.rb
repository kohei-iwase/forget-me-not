class MemoriesController < ApplicationController
	def create
    @portrait = Portrait.find(params[:portrait_id])
    @memory = Memory.new(memory_params)
    @memory.portrait_id = @portrait.id
    @memory.save
    redirect_to portrait_path(@portrait)
	end

    def show
        @memory = Memory.find(params[:id])
    end

    def edit
    end

    def update
    end

    def destroy
    end

		private
			def memory_params
    			params.require(:memory).permit(:memory,:image,:when,:title)
			end
end
