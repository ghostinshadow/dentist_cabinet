Rails.application.routes.draw do
  resources :words
  resources :dictionaries
  resources :patients
  devise_for :users
  root "cabinets#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
