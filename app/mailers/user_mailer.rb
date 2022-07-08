class UserMailer < ActionMailer::Base
  default :from => "myriam.delbreil@live.fr"

def registration_confirmation(user)
  @user = user
  mail(:to => @user.email, :subject => "Registration Confirmation")
end
