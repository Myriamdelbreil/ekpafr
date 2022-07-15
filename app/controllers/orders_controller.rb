class OrdersController < ApplicationController
  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    formation = Formation.find(params[:formation_id])
    order = Order.create!(formation: formation, amount: formation.prix, state: 'pending', user: current_user)
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: formation.titre,
        amount: formation.prix,
        currency: 'eur',
        quantity: 1
      }],
      success_url: "http://ekpafrance.herokuapp.com/inscriptions",
      cancel_url: "http://ekpafrance.herokuapp.com"
    )
    order.update(checkout_session_id: session.id)
    redirect_to new_formation_order_payment_path(formation, order), status: :see_other
  end
end
