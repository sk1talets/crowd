Rails.application.routes.draw do
  get 'sessions/new'

  resources :posts
  root 'posts#index'
  get 'posts/:id/voteup' => 'posts#voteup', :as => :post_voteup
  get 'posts/:id/votedown' => 'posts#votedown', :as => :post_votedown

  resources :comments, :only => [ :new, :create ]
  get 'comments/:id/voteup' => 'comments#voteup', :as => :comment_voteup
  get 'comments/:id/votedown' => 'comments#votedown', :as => :comment_votedown

  resources :users
  get 'signup' => 'users#new'
    
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

end
