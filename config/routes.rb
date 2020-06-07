Rails.application.routes.draw do 
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: [ :index, :show ] do
    resources :friendships, only: :create
    put 'friendship', to: 'friendships#update'
    delete 'friendship', to: 'friendships#destroy'
  end

  get 'users/:id/pending_requests', to: 'users#pending_requests', as: 'pending_requests'
  get 'users/:id/friends', to: 'users#friends', as: 'user_friends'


  root 'static_pages#home'

  resources :posts, only: [ :create, :update, :destroy ] do 
    resources :comments, only: [ :create, :destroy ]
    resources :like_relationships, only:[:create], as: 'likes'
    delete 'like_relationship', to:'like_relationships#destroy', as: 'unlike'
  end
  
end
