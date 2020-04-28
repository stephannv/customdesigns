Rails.application.routes.draw do
  get 'home/index'

  get 'me/edit', to: 'creators#edit', as: :edit_creator
  put 'me', to: 'creators#update', as: :update_creator

  resources :custom_designs

  resources :tags, only: :index

  resources :bookmarks, only: :index do
    collection do
      post '/:custom_design_id', to: 'bookmarks#create', as: :create
      delete '/:custom_design_id', to: 'bookmarks#destroy', as: :destroy
    end
  end

  root to: 'home#index'
end
