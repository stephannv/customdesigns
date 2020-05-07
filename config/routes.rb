Rails.application.routes.draw do
  get '/home/index'
  get '/search', to: 'search#index', as: :search

  get '/creator/:creator_id', to: 'creators#show', as: :creator
  get '/design/:design_id', to: 'custom_designs#show', as: :custom_design
  get '/design/:design_id/edit', to: 'custom_designs#edit', as: :edit_custom_design
  patch '/design/:design_id', to: 'custom_designs#update'

  resources :custom_designs, only: %i[new create destroy], param: :design_id do
    collection do
      get '/unpublished', action: 'unpublished', as: :unpublished
    end

    member do
      put '/publish', action: 'publish', as: :publish
      put '/unpublish', action: 'unpublish', as: :unpublish
    end
  end

  resources :tags, only: :index

  root to: 'home#index'
end
