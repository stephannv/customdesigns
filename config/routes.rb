Rails.application.routes.draw do
  get 'home/index'

  # CREATOR
  get 'me/edit', to: 'creators#edit', as: :edit_creator
  put 'me', to: 'creators#update', as: :update_creator

  # CUSTOM DESIGNS
  resources :custom_designs

  root to: 'home#index'
end
