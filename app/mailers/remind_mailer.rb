class RemindMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.remind_mailer.remind.subject
  #
  def remind_to_user(user)
  	@user = user
  	@anniversaries = @user.anniversaries
    @anniversary = @aniversaries.select{|Aniversary| annivesaries.todays? && aniversaries.reminder_mail }
  	mail(
      subject: "#{Dart.tommorrow}"は"<%=@anniversary.name%>", #メールのタイトル
      to: user.email #宛先
    ) do |format|
      format.text
    end
  end
end
