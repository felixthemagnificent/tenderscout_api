class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    super do |resource|
      if successfully_sent?(resource)
        token = Doorkeeper::AccessToken.create!({
                                                    :resource_owner_id  => resource.id,
                                                    :expires_in         => Doorkeeper.configuration.access_token_expires_in,
                                                    :use_refresh_token  => Doorkeeper.configuration.refresh_token_enabled?
                                                }).token
       return render json: token, status: 200
      else
       return render json: { error: resource.errors.messages }.to_json
      end
    end
  end

  end
