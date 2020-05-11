Rails.application.routes.draw do 
  devise_for :users
  resources :users, only: [ :index, :show ]
  root 'static_pages#home'
  resources :post, except:[:edit, :update, :delete] do 
    resources :comments, only:[:index, :new, :create]
  end
end
