class ContactsController < ApplicationController
  require 'mailjet'

  Mailjet.configure do |config|
    config.api_key = ENV['MJ_APIKEY_PUBLIC']
    config.secret_key = ENV['MJ_APIKEY_PRIVATE']
    config.default_from = 'myriam.delbreil@live.fr'
    # Mailjet API v3.1 is at the moment limited to Send API.
    # We’ve not set the version to it directly since there is no other endpoint in that version.
    # We recommend you create a dedicated instance of the wrapper set with it to send your emails.
    # If you're only using the gem to send emails, then you can safely set it to this version.
    # Otherwise, you can remove the dedicated line into config/initializers/mailjet.rb.
    config.api_version = 'v3.1'
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save!
      send_email_reserved(@contact)
      redirect_to root_path
    else
      redirect_to [formations_path], status: :see_other
    end
  end

  def thanks
  end

  private

  def send_email_reserved(contact)

    variable = Mailjet::Send.create(messages: [{
      'From'=> {
          'Email'=> "myriam.delbreil@gmail.com",
          'Name'=> 'Me'
      },
      'To'=> [
          {
              'Email'=> 'myriam.delbreil@live.fr',
              'Name'=> 'You'
          }
      ],
      'Subject'=> "Message de #{contact.email} - #{contact.name}",
      'TextPart'=> 'Greetings from Mailjet!',
      'HTMLPart'=> '<h3>Dear passenger 1, welcome to <a href=\'https://www.mailjet.com/\'>Mailjet</a>!</h3><br />May the delivery force be with you!'
      }]
    )

    p variable.attributes['Messages']
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end
