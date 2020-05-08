class MemoriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def create
    @portrait = Portrait.find(params[:portrait_id])
    @memory = Memory.new(memory_params)
    @memory.portrait_id = @portrait.id
    if @memory.save
      flash[:success] = '思い出を作成しました！'
      redirect_to portrait_memory_path(@portrait, @memory)
    else
      flash[:danger] = '思い出の作成に失敗しました'
      redirect_to portrait_path(@portrait)
    end
  end

  def show
    @portrait = Portrait.find(params[:portrait_id])
    @memory = Memory.find(params[:id])
    @user = @portrait.user
  end

  def index
    portrait = Portrait.find(params[:portrait_id])
  end

  def edit
    @portrait = Portrait.find(params[:portrait_id])
    @memory = Memory.find(params[:id])
  end

  def update
    @portrait = Portrait.find(params[:portrait_id])
    @memory = Memory.find(params[:id])
    if @memory.update(memory_params)
      flash[:success] = '思い出を更新に成功しました！'
      redirect_to portrait_memory_path(@portrait, @memory)
    else
      flash[:danger] = '思い出の更新に失敗しました'
      redirect_to edit_portrait_memory_path(@portrait, @memory)
    end
  end

  def destroy
    @portrait = Portrait.find(params[:portrait_id])
    @memory = Memory.find(params[:id])
    flash[:danger] = '思い出を削除しました' if @memory.destroy
    redirect_to portrait_path(@portrait)
  end

  def create_notification_flower(current_user)
    notification = current_user.active_notifications.new(
      mrmoty_id:self.id,
      visited_id:self.contributer.id,
      action:"flower"
    )
  notification.save if notification.valid?
  end

  private

  def memory_params
    params.require(:memory).permit(:memory, :image, :when, :title)
  end
end
