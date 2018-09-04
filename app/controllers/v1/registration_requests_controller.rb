class V1::RegistrationRequestsController < ApplicationController
  before_action :set_request, only: [:show, :update]
  before_action :set_industry, only: [:create]
  before_action :set_country, only: [:create]
  skip_before_action :authenticate_user!

  def index
    render json: RegistrationRequest.all
  end

  def create
    @request = RegistrationRequest.new(request_params)
    @request.do_processed = false
    @request.industry = @industry
    @request.country = @country

    if @request.save
      # TODO send email
      # PostmarkMailer.send_template(current_user.email, 'Registration request', 123, {})
      render json: @request, status: :created
    else
      render json: @request.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @request
  end

  def update
    @request.update(do_processed: true)
    # TODO send email
    # PostmarkMailer.send_template(current_user.email, 'Registration request approved', 123, {})
    render json: @request
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = RegistrationRequest.find(params[:id])
  end

  def set_industry
    @industry = Industry.find(request_params[:industry_id])
  end

  def set_country
    @country = Core::Country.find(request_params[:country_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_params
    params.permit(:fullname, :company, :company_size, :state, :country,
      :industry, :city, :turnover, :tender_level, :win_rate, :email, :phone,
      :number_public_contracts, :do_use_automation, :do_use_collaboration,
      :do_use_bid_no_bid, :do_use_bid_library, :do_use_feedback, :do_collaborate,
      :tender_complete_time, :organisation_count, :industry_id, :country_id,
      markets: []
    )
  end
end