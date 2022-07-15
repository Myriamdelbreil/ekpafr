class OrdersController < ApplicationController
  before_action :paypal_init, :except => [:show, :create]
  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    p params[:formation_id]
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

  def create_order
    formation = Formation.find(params[:formation_id])
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
      if order.save
        return render :json => {:token => response.result.id}, :status => :ok
      end
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

  private

  def paypal_init
    client_id = 'AdurcPY4JqwnFY6qKcEtIvYITb5_22nOO8i9FH5WWggKmCB1VLxf9R_UQHzNAE6O9taDhI0bHLP3FvLo'
    client_secret = 'EMLyf2UfO4VAvVC-h5_j_YhcPOWXeD-MJOadVmL77zWA_kZLWbf2ADlz7bbXepadvjSLK0nYmzbme4UI'
    environment = PayPal::SandboxEnvironment.new client_id, client_secret
    @client = PayPal::PayPalHttpClient.new environment
  end
end
