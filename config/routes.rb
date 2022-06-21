Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :formations, only: [:index, :show, :search] do
    resources :inscriptions, only: [:new, :create]
  end

  resources :temoignages, only: [:index]

  resources :inscriptions, only: [:index, :show]

  resource :contacts, only: [:new, :create]

  get "/about_us", to: "pages#about_us", as: "about_us"
  get "/cpf_explications", to: "pages#cpf_explications", as: "cpf_explications"
  get "search", to: "formations#search"
end
