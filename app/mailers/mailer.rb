require 'mailjet'

class Mailer < ActionMailer::Base

  layout 'mailer'

  def contact_form(contact)
    @contact = contact
    @to = "myriam.delbreil@live.fr"

    # mail(to: @to, subject: "Nouveau contact depuis le site") do |format|
    #   format.html
    # end

    variable = Mailjet::Send.create(messages: [{
      'From'=> {
        'Email'=> "#{@contact.email}",
        'Name'=> ''
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
  end

end
