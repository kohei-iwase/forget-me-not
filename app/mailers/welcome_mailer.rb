class WelcomeMailer < ApplicationMailer
  # テスト送信用のメーラー
  def welcome(user)
    @user = user
    mail to: user.email,
         subject: 'こんにちは！新しいユーザーが追加されました'
    end
end
