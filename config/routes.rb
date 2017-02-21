Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users
  root 'breweries#index'
  resources :beers
  resources :breweries
  resources :ratings, only: [:index, :new, :create, :destroy]
  resources :places, only:[:index, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :styles 
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  get 'places', to: 'places#index'
  post 'places', to:'places#search'
  delete 'signout', to: 'sessions#destroy'
  #get 'kaikki_bisset', to: 'beers#index'
  #get 'ratings', to: 'ratings#index'
  #get 'ratings/new', to:'ratings#new'
  #post 'ratings', to: 'ratings#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
