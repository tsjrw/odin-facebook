Rails.application.routes.draw do 
  devise_for :users
  resources :users, only: [ :index, :show ]
  root 'static_pages#home'
  resources :posts, only: [ :create, :update, :destroy ] do 
    resources :comments, only: [ :create, :destroy ]
    resources :like_relationships, only:[:create], as: 'likes'
    delete 'like_relationship', to:'like_relationships#destroy', as: 'unlike'
  end
  
end
