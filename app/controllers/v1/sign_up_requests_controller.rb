class V1::SignUpRequestsController < ApplicationController
  include UserConfirmationNotifier
  before_action :set_request, only: [:show, :update]
  skip_before_action :authenticate_user!

  def index
    render json: SignUpRequest.all
  end

  def create
    p(request_params)
    result = CreateSignUpRequest.call(params: request_params)
    if result.success?
      user = User.find_by(email: request_params[:email])
      send_confirmation(user)
      render json: {messgage: 'Confirm your account in email'}
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @request
  end

  def update
    result = UpdateSignUpRequest.call(params: request_params, request: @request)
    if result.success?
      render json: result.request, status: :created
    else
      render json: result.errors, status: :unprocessable_entity
    end
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
  # def password_params
  #   params.permit(:password)
  # end
end