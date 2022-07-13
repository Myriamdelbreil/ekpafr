class UsersController < ApplicationController
  def create
    # Create the user from params
    @user = User.new(user_params)
    if @user.save
      # Deliver the signup email
      UserNotifierMailer.send_signup_email(@user).deliver
      redirect_to(@user, :notice => 'User created')
    else
      render :action => 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:nom, :prenom, :admin, :telephone, :diplome, :site_connu, :newsletter, :addresse, :email_confirmation, :password, :email, :login, :email_confirmation)
  end
end
