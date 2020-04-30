class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    #フォロー通知のメソッド
    @user.create_notification_follow!(current_user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: @user) }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: @user) }
      format.js
    end
  end
end
