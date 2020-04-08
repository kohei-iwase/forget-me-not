class MemoriesController < ApplicationController
	def create
    @portrait = Portrait.find(params[:portrait_id])
    @memory = Memory.new(memory_params)
    @memory.portrait_id = @portrait.id
    @memory.save
    redirect_to portrait_memory_path(@portrait,@memory)
	end

    def show
        @portrait = Portrait.find(params[:portrait_id])
        @memory = Memory.find(params[:id])
    end

    def edit
        @portrait = Portrait.find(params[:portrait_id])
        @memory = Memory.find(params[:id])
    end

    def update
        @portrait = Portrait.find(params[:portrait_id])
        @memory = Memory.find(params[:id])
        @memory.update(memory_params)
        redirect_to portrait_memory_path(@memory)
    end

    def destroy
        @portrait = Portrait.find(params[:portrait_id])
        @memory = Memory.find(params[:id])
        @memory.destroy
        redirect_to portrait_path(@portrait)
    end

		private
			def memory_params
    			params.require(:memory).permit(:memory,:image,:when,:title)
			end
end
