class V1::SignUpRequestsController < ApplicationController
  include UserConfirmationNotifier
  before_action :set_request, only: [:show, :update]
  skip_before_action :authenticate_user!

  def index
    render json: SignUpRequest.all
  end

  def create
    result = CreateSignUpRequest.call(params: request_params)
    if result.success?
      if User.exists?(email: request_params[:email])
        return render json: {error: 'User already exists'}, status: :unprocessable_entity
      end
      @user = User.new(user_params)
      render json: @user.errors, status: :unprocessable_entity unless @user.save
      @profile = @user.profiles.new(profile_params)
      country = Core::Country.find_by(id: request_params[:country_id])
      unless country.present?
        render json: { error: :unprocessable_entity, error_description: 'Country not found'},
                      code: :unprocessable_entity
      end
      @profile.country = country
      render json: @user.errors, status: :unprocessable_entity, code: :unprocessable_entity unless @profile.save
      @contacts =  @profile.contacts.new(contact_type: 'phone', value: contact_params[:phone])
      render json: @user.errors, status: :unprocessable_entity, code: :unprocessable_entity unless @contacts.save
      send_confirmation(@user)
      render json: {messgage: 'Confirm your account in email'}
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @request
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = SignUpRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_params
    params.permit(:fullname, :company, :state, :password,
                  :city, :tender_level, :email, :phone,
                  :number_public_contracts, :tender_complete_time,
                  :organisation_count, :industry_id, :country_id,
                  markets: []
    )
  end

  def user_params
    params.permit(:email ,:password)
  end

  def profile_params
    params.permit(:fullname, :city)
  end

  def contact_params
    params.permit(:phone)
  end

end