Rails.application.routes.draw do

  # namespace :marketplace do
  #   resources :tender_criteria_sections
  # end
  # namespace :marketplace do
  #   resources :tender_committees
  # end
  # namespace :marketplace do
  #   resources :tender_criteria
  # end
  # namespace :marketplace do
  #   resources :tender_tasks
  # end
  resources :contacts
  # use_doorkeeper
  devise_for :users, defaults: { format: :json }
  namespace :v1 do
    post 'scrapper/input' => 'scrapper/scrapper#input'

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
      # namespace :compete do
      #   resources :bid_no_bid_answers
      # end
      resources :bid_no_bid_answers
      resources :bid_no_bid_questions do
      member do
        get :bid_no_bid_question_comments, to: 'bid_no_bid_questions#bid_no_bid_question_comments'
        get :bid_no_bid_question_notes, to: 'bid_no_bid_questions#bid_no_bid_question_notes'
      end
      end
      
      resources :tenders do
        member do
          put :publish
          get :compete
          get :best_bidsense_profiles
          get :current_buyer_company_won_list
          get :complete_organization_tenders_list
        end
        member do
          scope :compete do
            get :bid_no_bid_answers, to: 'tenders#get_bnb_data'
            post :bid_no_bid_answer, to: 'tenders#process_bnb_data'
          end
        end

        resources :collaboration_interests
        resources :tender_collaborators, path: 'collaborators'
        resources :tender_criteria, path: 'criteries' do
          resources :tender_award_criteria_answer, path: 'answers' do
            collection do
              put :close
            end
          end
        end
        resources :tender_tasks, path: 'tasks' do
          member do
            get :tender_task_comments, to: 'tender_tasks#tender_task_comments'
            get :tender_task_notes, to: 'tender_tasks#tender_task_notes'
          end
          resources :tender_task_answers, path: 'answers' do
            collection do
              put :close
            end
          end
        end
        resources :tender_criteria_sections, path: 'criteria_sections' do
          collection do
            post :bulk_create
          end
        end
        resources :tender_award_criteria_sections, path: 'award_criteria_sections' do
          collection do
            post :bulk_create
          end
        end
        resources :tender_award_criteria, path: 'award_criteria' do
          member do
            get :tender_award_criteria_comments, to: 'tender_award_criteria#tender_award_criteria_comments'
            get :tender_award_criteria_notes, to: 'tender_award_criteria#tender_award_criteria_notes'
          end
        end
        resources :tender_attachments
        resources :tender_task_sections, path: 'task_sections' do
          collection do
            post :bulk_create
          end
        end
        resources :tender_suppliers, path: 'suppliers' do
          member do
            put :invite_approve
          end
        end
        resources :tender_compete_comments, path: 'compete_comments' do
          member do
            post :answer
          end
        end
      end
    end
    put :update_password, to: 'users#update_password', path: 'users/password/update'
    resources :assistances
    resources :users do
      collection do
        get :search
      end
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
    get :user_tender_statistic, to: 'users#user_tender_statistic'
    resources :comments do
      member do
        get :childrens, to: 'comments#comment_childrens'
      end
    end
    resources :notes
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
    post 'create_ticket', to: 'zen_service#create_ticket'
    get 'sign_into_zendesk', to: 'zen_service#sign_into_zendesk'
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
      get :all_codes, path: 'all_codes', to: 'industry_codes#all_codes'
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
