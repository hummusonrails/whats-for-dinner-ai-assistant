Rails.application.routes.draw do
  get 'uploads/:path', to: 'uploads#show', constraints: { path: /.+/ }
  get 'about', to: 'home#about'

  resources :recipes, only: [:new, :create, :show, :index]

  root 'home#index'
end
