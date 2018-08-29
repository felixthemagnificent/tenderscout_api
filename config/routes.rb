Rails.application.routes.draw do

  namespace :marketplace do
    resources :tender_committees
  end
  namespace :marketplace do
    resources :tender_criteria
  end
  namespace :marketplace do
    resources :tender_tasks
  end
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
    namespace :marketplace do
      resources :tenders do
        resources :tender_attachments
      end
      resources :tender_committees
      resources :tender_criteria
      resources :tender_tasks
    end
    resources :users do
      resources :profiles do
        member do
          post :avatar, to: 'profiles#create_avatar'
          delete :avatar, to: 'profiles#destroy_avatar'
          post :cover_img, to: 'profiles#create_cover_img'
          delete :cover_img, to: 'profiles#destroy_cover_img'
        end
        resources :case_studies, path: 'case_study' do
          member do
            delete :remove_image, path: 'image/:image_id', to: 'case_studies#remove_image'
          end
        end
      end
    end
    resources :profiles, path: 'my/profiles'
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
    resources :registration_requests, path: 'user/registration_request' do
      member do
        put 'process', to: 'registration_requests#update'
      end
    end

    namespace :dictionaries do
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
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
