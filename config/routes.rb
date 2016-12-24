Rails.application.routes.draw do
  resources :exchange_rates
  root to: 'exchange_rates#current_rate'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
