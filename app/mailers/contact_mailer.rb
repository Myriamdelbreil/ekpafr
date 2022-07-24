class ContactMailer < ApplicationMailer
  default from:'ekpafr@gmail.com'
  def send_contact_email(contact)
    mail(to: "ekpafr@gmail.com", subject: "Welcome")
  end
end
