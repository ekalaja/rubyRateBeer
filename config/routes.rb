Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users do
    post 'toggle_blocked', on: :member
  end
  root 'breweries#index'
  resources :beers
  resources :ratings, only: [:index, :new, :create, :destroy]
  resources :places, only:[:index, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :styles 
  resources :breweries do
    post 'toggle_activity', on: :member
  end

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
