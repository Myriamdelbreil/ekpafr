class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save!
      UserMailer.send_welcome(user).deliver_now
    else
      redirect_to formations_path
    end
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:nom, :email, :prenom, :telephone, :diplome, :site_connu, :newsletter, :addresse, :email_confirmation)
  end
end
