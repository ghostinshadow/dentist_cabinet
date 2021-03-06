Rails.application.routes.draw do
  resources :dictionaries do
    resources :words, shallow: true
    collection do
      get :doctors_and_cities
      get :work_specific_dictionaries
    end
  end
  resources :patients , shallow: true do
    member do
      get :performed_works
    end
    resources :appointments, shallow: true do
    	resources :performed_works
    end
    resources :patient_pictures, shallow: true, except: [:new, :edit, :update]
  end
  get :works_performed_on_tooth, controller: "performed_works"
  devise_for :users
  root "cabinets#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
 