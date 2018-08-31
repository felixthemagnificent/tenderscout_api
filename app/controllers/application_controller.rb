class ApplicationController < ActionController::API

  before_action :authenticate_user!, unless: :public_endpoint?


  protected

    def public_endpoint?
      public_endpoints = [
        { controller: 'registration_requests', action: 'create' },
        { controller: 'industries', action: 'index' },
        { controller: 'countries', action: 'index' },
      ]
      public_endpoints.map{ |endpoint| endpoint[:controller] == controller_name && endpoint[:action] == action_name }.include?(true)
    end
end
