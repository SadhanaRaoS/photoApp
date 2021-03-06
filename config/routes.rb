Rails.application.routes.draw do
  root to: 'photos#index'
  resources :photos do 
  	post 'publish', on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'signup' => 'users#new'
  get 'login' => 'users#login'
  post '/users' => 'users#create'
end
