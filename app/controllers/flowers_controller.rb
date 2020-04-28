class FlowersController < ApplicationController
  def create
    memory = Memory.find(params[:memory_id])
    flower = current_user.flowers.new(memory_id: memory.id)
    flower.save
    # redirect_to portrait_path(portrait)
    # portrait.create_notification_bouquet!(current_user)
  end

  def destroy
    memory = Memory.find(params[:memory_id])
    flower = current_user.flowers.find_by(memory_id: memory.id)
    flower.destroy
    # redirect_to portrait_path(portrait)
  end
end
