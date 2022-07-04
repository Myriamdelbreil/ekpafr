require 'mailjet'

class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      send_email_reserved(@contact)
      redirect_to root_path, flash[:notice] = "mail envoyé!"
    else
      render :new
    end
  end

  def thanks
  end

  private

  def send_email_reserved(contact)
    variable = Mailjet::Send.create(messages: [{
      'From'=> {
        'Email'=> "#{contact.email}",
        'Name'=> "#{contact.name}"
      },
      'To'=> [
        {
          'Email'=> 'myriam.delbreil@gmail.com',
          'Name'=> 'Myriam'
        }
      ],
      'Subject'=> 'Greetings from Mailjet.',
      'TextPart'=> 'My first Mailjet email',
      'HTMLPart'=> '<h3>Dear passenger 1, welcome to <a href=\'https://www.mailjet.com/\'>Mailjet</a>!</h3><br />May the delivery force be with you!',
      'CustomID' => 'AppGettingStartedTest'
    }]
    )
    p variable.attributes[:messages]
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end
