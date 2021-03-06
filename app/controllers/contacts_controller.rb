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
    errors_code = ['400', '401', '406', '429', '500' ]
    puts response.status_code
    puts response.body
    puts response.headers

    if errors_code.include?(response.status_code)
      render :new
    else
      redirect_to root_path
    end
  end


  private

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end
