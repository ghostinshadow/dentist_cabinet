Rails.application.routes.draw do
  resources :words
  resources :dictionaries do
    collection do
      get :doctors_and_cities
      get :work_specific_dictionaries
    end
  end
  resources :patients , shallow: true do
    resources :appointments, shallow: true do
    	resources :performed_works
    end
  end
  devise_for :users
  root "cabinets#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
 