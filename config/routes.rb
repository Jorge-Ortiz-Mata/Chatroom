Rails.application.routes.draw do
  devise_for :users
  root 'rooms#index'
  resources :rooms do
    resources :messages, only: [:new, :create, :destroy]
  end
  post '/add/user', to: 'rooms#add_user'
  get 'message/edit', to: 'messages#message_edit', as: 'message_edit'
  resources :messages
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
