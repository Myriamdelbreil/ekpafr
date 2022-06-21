class InscriptionsController < ApplicationController
  def index
    @pagy, @inscriptions = pagy(Inscription.includes(:formation).where(user: current_user).all, items: 10)
    @inscriptions_count = Inscription.includes(:formation).where(user: current_user).all.count
  end

  def show
    @inscription = Inscription.find(params[:id])
    @formation = @inscription.formation
  end

  def new
    @new_inscription = Inscription.new
    @formation = Formation.find(params[:formation_id])
    @user = current_user
  end

  def create
    @new_inscription = Inscription.new(params_inscription)
    @new_inscription.formation = Formation.find(params[:formation_id])
    @new_inscription.user = current_user
    if @new_inscription.save
      redirect_to inscription_path(@new_inscription), notice: "Félicitations, vous êtes bien inscrits !"
    else
      redirect_to formation_path(Formation.find(params[:formation_id])), alert: "Désolés, une erreur s'est produite, merci de réessayer."
    end
  end
end
