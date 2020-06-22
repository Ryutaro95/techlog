Rails.application.routes.draw do
  root "posts#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: %i(show destroy)

  get '/admin/deleted', to: 'users#deleted_user', as: 'deleted_user'
  namespace :admin do
    resources :users, except: %i(new create edit update)
  end
  resources :posts do
    resources :comments, only: %i(create destroy)
  end
  resources :user_follow_relations, only: %i(create destroy)
  resources :likes, only: %i(create destroy)
  resources :stocks, only: %i(index create destroy)
end
