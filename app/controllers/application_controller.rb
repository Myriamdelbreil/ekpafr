class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:diplome, :site_connu, :email_confirmation, :nom, :prenom, :addresse, :telephone, :newsletter, :photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:diplome, :site_connu, :email_confirmation, :nom, :prenom, :addresse, :telephone, :newsletter, :photo])
  end
end
