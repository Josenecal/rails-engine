Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'api/v1/merchants', to: 'api/v1/merchants#index'
  get 'api/v1/merchants/:id', to: 'api/v1/merchants#show'

  get 'api/v1/merchants/:id/items', to: 'api/v1/merchant_items#index'

  get 'api/v1/items', to: 'api/v1/items#index'
  get 'api/v1/items/:id/', to: 'api/v1/items#show'
end
