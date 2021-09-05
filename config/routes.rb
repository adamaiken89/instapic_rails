Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :sessions, only: [:create]
  resources :posts, only: [:create, :index]

  match "*unmatched", to: "errors#not_found", via: :all
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
