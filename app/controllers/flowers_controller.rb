class FlowersController < ApplicationController
  def create
    memory = Memory.find(params[:memory_id])
    flower = current_user.flowers.new(memory_id: memory.id)
    flower.save
        # 通知の作成献花時のみ追加
    memory.create_notification_flower(current_user)
    # redirect_to portrait_path(portrait)
  end

  def destroy
    memory = Memory.find(params[:memory_id])
    flower = current_user.flowers.find_by(memory_id: memory.id)
    flower.destroy
    # redirect_to portrait_path(portrait)
  end
end
