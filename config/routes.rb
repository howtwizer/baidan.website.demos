Rails.application.routes.draw do
  resources :search, only: :index
  resource :tabular, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
