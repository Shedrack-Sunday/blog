Rails.application.routes.draw do
  root 'users#index'
  resources :users, only: [:index, :show] do
  resources :posts, only: [:index, :show]
  end   
  # get 'users/index'
  # get 'users/show'
  # get 'posts/index'
  # get 'posts/show'
  
end
