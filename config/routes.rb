Rails.application.routes.draw do

  resources :contacts
  use_doorkeeper
  devise_for :users
  namespace :v1 do
    resources :users do
      resources :profiles
    end
    resources :search_monitors
    resources :countries
    resources :roles
    resources :industries
    resources :african_codes
    resources :classification_codes
    resources :gsin_codes
    resources :ngip_codes
    resources :nigp_codes
    resources :sfgov_codes
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
