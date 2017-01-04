Rails.application.routes.draw do
  resources :words
  resources :dictionaries do
  	collection do
  		get :doctors_and_cities
  	end
  end
  resources :patients
  devise_for :users
  root "cabinets#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
