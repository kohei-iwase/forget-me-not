class WelcomeMailer < ApplicationMailer
	def welcome(user)
    	@user = user
    	mail to:      user.email,
        	 subject: 'こんにちは！新しいユーザーが追加されました'
  	end
end
