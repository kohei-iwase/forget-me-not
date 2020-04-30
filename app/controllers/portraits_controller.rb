class PortraitsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def new
    @portrait = Portrait.new
  end

  # アルバムの保存
  def create
    @portrait = Portrait.new(portrait_params)
    @portrait.user_id = current_user.id
    @user = current_user
    if @portrait.save
      #        WelcomeMailer.welcome(@user).deliver　メールのテスト用
      flash[:success] = 'アルバムを作成しました。'
      redirect_to edit_portrait_path(@portrait.id)
    else
      #        @timelines = []
      flash[:danger] = 'アルバムの作成に失敗しました。'
      redirect_to new_portrait_path
    end
  end

  def index
    @portraits = Portrait.order(created_at: :desc).page(params[:page]).per(4)
    @memrories = Memory.order(created_at: :desc).page(params[:page]).per(4)
  end

  def show
    @portrait = Portrait.find(params[:id])
    @user = @portrait.user
    @memrories = @portrait.memories.all
    @memory = Memory.new
  end

  def edit
    @user = current_user
    @portrait = Portrait.find(params[:id])
    redirect_to portrait_path(@portrait) if @portrait.user_id != current_user.id
    # 正規ユーザー以外の編集を認めない
  end

  def update
    @portrait = Portrait.find(params[:id])
    if @portrait.update(portrait_params)
      flash[:success] = 'アルバムの更新に成功しました！'
      redirect_to portrait_path(@portrait)
    else
      flash[:danger] = 'アルバムの更新に失敗しました'
      redirect_to edit_portrait_path(@portrait)
  end
  end

  def destroy
    @portrait = Portrait.find(params[:id])
    flash[:danger] = 'アルバムを削除しました' if @portrait.destroy
    redirect_to portraits_path
  end

  # ポートレイトのストロングパラメータ
  private

  def portrait_params
    params.require(:portrait).permit(:name, :image, :age, :gender, :species, :date_of_birth, :anniversary,
                                     :likes_and_dislikes, :interest, :specialty, :family, :personality, :found,
                                     :more_about_me)
   end
  #     def baria_user
  #       unless params[:user_id].to_i == current_user.id
  #         redirect_to user_path(current_user)  #現在のユーザー詳細に戻る
  #       end
  # end
end
