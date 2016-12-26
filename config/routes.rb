Rails.application.routes.draw do
  get 'admin', to: 'exchange_rates#edit', as: 'edit_exchange_rate'
  patch 'admin', to: 'exchange_rates#update', as: 'exchange_rate'
  root to: 'exchange_rates#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
