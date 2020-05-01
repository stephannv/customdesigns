Rails.application.routes.draw do
  get 'home/index'
  get 'search', to: 'search#index', as: :search

  get 'creator/:permanlink', to: 'creators#show', as: :creator
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

  post '/hearts/:custom_design_id', to: 'hearts#create', as: :create_hearts
  delete '/hearts/:custom_design_id', to: 'hearts#destroy', as: :destroy_hearts

  root to: 'home#index'
end
