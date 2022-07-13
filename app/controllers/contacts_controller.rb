class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    from = "myriam.delbreil@live.fr"
    to = 'myriam.delbreil@live.fr'
    subject = ' '
    content = Content.new(type: 'text/plain', value: "De : #{@contact.email} - #{@contact.name} - #{@contact.content}")
    mail = Mail.create(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end


  private

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end
