class OrdersController < ApplicationController
  before_action :paypal_init, :except => [:show, :create]
  skip_before_action :verify_authenticity_token

  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    formation = Formation.find(params[:formation_id])
    order = Order.create!(formation: formation, amount: formation.prix, state: 'pending', user: current_user)
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: [{
        name: formation.titre,
        amount: formation.prix * 100,
        currency: 'eur',
        quantity: 1,
      }],
      success_url: 'http://www.ekpafrance.com/' + "success?session_id={CHECKOUT_SESSION_ID }",
      cancel_url: 'http://www.ekpafrance.com'
    )
    order.update(checkout_session_id: session.id)
    redirect_to new_formation_order_payment_path(formation, order), status: :see_other
  end

  def create_order
    price = formation.prix
    request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
    request.request_body({
      :intent => 'CAPTURE',
      :purchase_units => [
        {
          :amount => {
            :currency_code => 'USD',
            :value => price
          }
        }
      ]
    })

    begin
      response = @client.execute request
      order = Order.new
      order.price = price.to_i
      order.token = response.result.id
      return render :json => {:token => response.result.id}, :status => :ok if order.save
      rescue PayPalHttp::HttpError => ioe
      # HANDLE THE ERROR
    end
  end

  def capture_order
    request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest::new params[:order_id]
    begin
      response = @client.execute request
      order = Order.find_by :token => params[:order_id]
      order.paid = response.result.status == 'COMPLETED'
      if order.save
        return render :json => {:status => response.result.status}, :status => :ok
      end
    rescue PayPalHttp::HttpError => ioe
      # HANDLE THE ERROR
    end
  end

  def stripe_success
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @customer = Stripe::Customer.retrieve(session.customer)
  end

  private

  def paypal_init
    environment = PayPal::SandboxEnvironment.new ENV['client_id'], ENV['client_secret']
    @client = PayPal::PayPalHttpClient.new environment
  end
end
