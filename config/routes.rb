Rails.application.routes.draw do

  resources :contacts
  # use_doorkeeper
  devise_for :users, defaults: { format: :json }
  namespace :v1 do
    use_doorkeeper scope: 'auth' do
      controllers tokens: 'api_auth'
      skip_controllers :authorizations, :applications, :authorized_applications, :tokens
    end
    scope :auth do
      post 'login' => 'auth#create'
      post 'logoff' => 'auth#logoff'
      post 'forget_password' => 'auth#forget_password'
      post 'reset_password' => 'auth#reset_password'
    end
    resources :users do
      resources :profiles
    end
    resources :search_monitors, path: 'bidder/monitor' do
      member do
        put :archive
        post :share
        put :favourite, to: 'search_monitors#add_favourite'
        delete :favourite, to: 'search_monitors#delete_favourite'
        get :result
      end
      collection do
        get :all_result, to: 'search_monitors#all_results'
        post :preview
        get :search
      end
    end
    post 'bidder/monitor/preview' => 'search_monitors#preview'
    resources :countries
    resources :roles
    resources :industries
    resources :industry_codes
    resources :african_codes
    resources :classification_codes
    resources :gsin_codes
    resources :ngip_codes
    resources :nigp_codes
    resources :sfgov_codes
    resources :registration_requests, path: 'users/registration_request' do
      member do
        put 'process', to: 'registration_requests#update'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
