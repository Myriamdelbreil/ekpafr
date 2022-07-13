class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    data = JSON.parse('{
      "personalizations": [
        {
          "to": [
            {
              "email": "myriam.delbreil@live.fr"
            }
          ],
          "subject": " "
        }
      ],
      "from": {
        "email": "myriam.delbreil@live.fr"
      },
      "content": [
        {
          "type": "text/plain",
          "value": " "
        }
      ]
    }')
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    data["content"].first["value"] = "De : #{@contact.email} - #{@contact.name} \n #{@contact.content}"
    response = sg.client.mail._("send").post(request_body: data)
    puts data
    puts response.status_code
    puts response.body
    puts response.headers
    # byebug
  end


  private

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end
