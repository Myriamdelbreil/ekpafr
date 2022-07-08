
class UsersController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      if user.email_confirmed
      redirect_to formations_path
      else
          flash.now[:alert] = 'Please activate your account by following the instructions in the account confirmation email you received to proceed'
          render 'new'
      end
    else
       flash.now[:alert] = 'Invalid email/password combination' # Not quite right!
       render 'new'
    end
  end
end
