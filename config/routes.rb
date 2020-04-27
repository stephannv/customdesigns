Rails.application.routes.draw do
  get 'home/index'

  get 'me/edit', to: 'creators#edit', as: :edit_creator
  put 'me', to: 'creators#update', as: :update_creator

  resources :custom_designs

  resources :tags, only: :index
  root to: 'home#index'
end
