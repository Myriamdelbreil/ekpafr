class UserMailer < ApplicationMailer
  default from: 'myriam.delbreil@gmail.com'

  def send_welcome(user)
    mail(to: user.email, subject: 'Welcome')
  end
end
