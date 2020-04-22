class ApplicationMailer < ActionMailer::Base
  default from: 'forget-me-not',
  		  bcc:      ENV['EMAIL_ADDRESS'],
          reply_to: ENV['EMAIL_ADDRESS']
  layout 'mailer'
end
