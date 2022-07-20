class InscriptionsController < ApplicationController
  def index
    @pagy, @inscriptions = pagy(Inscription.includes(:formation).where(user: current_user).all, items: 10)
    @inscriptions_count = Inscription.includes(:formation).where(user: current_user).all.count
    @new_inscription = Inscription.new
    @order = current_user.orders.where(state: "pending").last
    @formation = @order.formation
  end

  def show
    @inscription = Inscription.find(params[:id])
    @formation = @inscription.formation
  end

  def create
    @new_inscription = Inscription.new(params_inscription)
    p params_inscription
    @order = current_user.orders.last
    @new_inscription.formation = @order.formation
    @new_inscription.user = current_user
    @new_inscription.order = @order
    session = Stripe::Checkout::Session.retrieve(@order.checkout_session_id)
    if session.payment_status == "paid"
      @order.state = "paid"
      @new_inscription.save!
      redirect_to inscription_path(@new_inscription), notice: "Félicitations, vous êtes bien inscrits !"
    else
      redirect_to error_path
    end
  end

  private

  def params_inscription
    params.require(:inscription).permit(:formation_id, :user_id, :order_id)
  end
end
