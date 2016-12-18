Rails.application.routes.draw do
  root 'pages#index'
  get 'services', to: 'pages#services'
  get 'restaurant', to: 'pages#restaurant'
  get 'contacts', to: 'pages#contacts'
  get 'rooms', to: 'rooms#index'
  get 'rooms/single-standart', to: 'rooms#single_standart'
  get 'rooms/single-standart-better', to: 'rooms#single_standart_better'
  get 'rooms/double-standart', to: 'rooms#double_standart'
  get 'rooms/single-halfluxury', to: 'rooms#single_halfluxury'
  get 'rooms/double-halfluxury', to: 'rooms#double_halfluxury'
  get 'rooms/luxury', to: 'rooms#luxury'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :reservations, only: [:new, :create]
  resources :reviews, only: [:index, :create, :destroy]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
