class RemindMailer < ApplicationMailer

  def remind_to_user(user)
  	@user = user
    @anniversary = @one_anniversary
  	mail(
      subject: "#{Dart.tommorrow}は<%=@anniversary.name%>", #メールのタイトル
      to: user.email #宛先
    )
  end
end
