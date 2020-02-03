Rails.application.routes.draw do
  root "posts#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: %i(show)
  resources :posts do
    resources :comments, only: %i(create destroy)
    collection { get "search" }
  end
  resources :user_follow_relations, only: %i(create destroy)
  resources :likes, only: %i(create destroy)
  resources :stocks, only: %i(index create destroy)
end
