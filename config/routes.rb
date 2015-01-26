Rails.application.routes.draw do
    resources :posts    
    root 'posts#index'
    
    resources :users
    get 'signup' => 'users#new'
end
