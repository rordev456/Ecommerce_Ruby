# frozen_string_literal: true

Rails.application.routes.draw do
  get 'orders/index'
  devise_for :views
  devise_for :users
  resources :pages, :categories, :orders
  resources :order_details
  resource :carts, only: [:show]
  resources :products, only: %i[index show] do
    collection do
      get 'search_results'
    end
  end
  resources :categories, only: %i[index show]

  # 'as' names your path.
  get '/static/:permalink', to: 'pages#permalink', as: 'permalink'
  post 'products/add_to_cart/:id&:quantity', to: 'products#add_to_cart', as: 'add_to_cart'
  delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'
  post 'products/update_the_cart/:id&:quantity/', to: 'products#edit_the_cart', as: 'edit_cart'

  root 'products#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
