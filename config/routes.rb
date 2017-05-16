Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'users#facebook'
  #get 'auth/failure', to: redirect('/')
  #get 'signout', to: 'users#destroy', as: 'signout'
  resources :products
	namespace :api do 
		resources :users
	end
  resources :users do
  collection do 
       get 'sign_in'
       post 'signup'
       delete 'logout'
  	end
  end
  root to: "products#index" 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
