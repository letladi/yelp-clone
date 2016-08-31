Rails.application.routes.draw do
	root 'ui#index'
	get 'ui/(:action)', controller: 'ui'
	get 'register', to: 'users#new'

	resources :users, only: [:create]
end
