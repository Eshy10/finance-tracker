Rails.application.routes.draw do
  get 'friendships/friend_list'
  resources :user_stocks
  get 'stocks/search'
  get 'friendships/search'
  get 'users/my_portfolio'
  devise_for :users
  root to: 'homes#index'
  resources :friendships
  resources :users, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
