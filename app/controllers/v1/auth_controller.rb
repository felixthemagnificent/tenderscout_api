class V1::AuthController < Doorkeeper::TokensController

  def create
    if super == :ok
      print 'sign_zendesk'
      # byebug
    end
  end

  def logoff
    if doorkeeper_token
      doorkeeper_token.destroy
      render json: {}, status: :ok
    else
      render json: {}, status: 401
    end
  end

  def forget_password
    user = User.where(email: params[:email]).first
    user.send_reset_password_instructions if user
    render json: nil, status: :ok
  end

  def reset_password
    password = params[:password]
    password_confirmation = params[:password_confirmation]
    reset_token = params[:reset_password_token]
    user = User.with_reset_password_token(reset_token)
    if user
      if password == password_confirmation
        user.reset_password(password, password_confirmation)
        user.save
        render json: {
          name: 'successful',
          error: 'Password reset successfully'
        }, status: 200
      else
        render json: {
          name: 'passwords_not_equal',
          error: 'Password not equal with confirmation'
        }, status: 500
      end
    else
    render json: {
        name: 'invalid_token',
        error: 'Reset token is invalid'
      }, status: 500
    end
  end
end