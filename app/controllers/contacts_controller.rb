class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.valid?
      ContactMailer.contact(@message).deliver_now
      flash[:notice] = "We have received your message and will be in touch soon!"
      render :index
    else
      flash[:notice] = "There was an error sending your message. Please try again."
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :phone_number, :body, :nickname, :captcha)
  end
end
