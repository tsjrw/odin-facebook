Rails.application.routes.draw do 
  devise_for :users
  resources :users, only: [ :index, :show ]
  root 'static_pages#home'
  resources :posts, except:[:edit, :update, :delete] do 
    resources :comments, only:[:create]
  end
end
