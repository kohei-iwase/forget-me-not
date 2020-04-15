class RemindMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.remind_mailer.remind.subject
  #
  def remind(user)
  	@user = User.find_by(id: user)
  	@aniversaries = @user.portrait.aniversaries
  	@aniversaries = @aniversaries.select{|Aniversary| anivesaries.todays? && aniversaries.reminder_mail }
  	mail(to: @user.email,subject: "[#{Dart.today}]"は)
  end
end
