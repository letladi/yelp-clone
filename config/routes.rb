Rails.application.routes.draw do
	root 'ui#index'
	get 'ui/(:action)', controller: 'ui'
	get 'register', to: 'users#new'
	post 'register', to: 'users#create'
	get 'login', to: 'sessions#new'
	post 'login', to: 'sessions#create'
	delete 'logout', to: 'sessions#destroy'
end
