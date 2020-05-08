class BouquetsController < ApplicationController
  def create
    # 献花の作成
    portrait = Portrait.find(params[:portrait_id])
    bouquet = current_user.bouquets.new(portrait_id: portrait.id)
    bouquet.save
    # 通知の作成献花時のみ追加
    portrait.create_notification_bouquet(current_user)
    redirect_to portrait_path(portrait)
  end

  #そもそもdestroyメソッドがいるかは後で考える
  def destroy
    portrait = Portrait.find(params[:portrait_id])
    bouquet = current_user.bouquets.find_by(portrait_id: portrait.id)
    bouquet.destroy
    redirect_to portrait_path(portrait)
  end
end
