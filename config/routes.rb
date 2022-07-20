Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :formations, only: [:index, :show, :search] do
    resources :inscriptions, only: [:new, :create]
    resources :orders, only: [:create] do
      resources :payments, only: :new
    end
  end

  resources :orders, only: :show

  resources :temoignages, only: [:index]

  resources :inscriptions, only: [:index, :show]

  resource :contacts, only: [:new, :create]
  get "/about_us", to: "pages#about_us", as: "about_us"
  get "/cpf_explications", to: "pages#cpf_explications", as: "cpf_explications"
  get "search", to: "formations#search"

  # mount StripeEvent::Engine, at: '/stripe-webhooks'
  resources :webhooks, only: [:create]

  post :create_order, :to => 'orders#create_order'
  post :capture_order, :to => 'orders#capture_order'

end
