Rails.application.routes.draw do
  root 'hotels#index'
  resources :hotels
  resources :rooms
  resources :room_rates
end
