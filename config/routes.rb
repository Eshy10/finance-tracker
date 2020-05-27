Rails.application.routes.draw do
  resources :user_stocks
  get 'stocks/search'
  get 'users/my_portfolio'
  devise_for :users
  root to: 'homes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
