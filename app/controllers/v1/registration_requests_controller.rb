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
      CustomPostmarkMailer.template_email(
        'piskovoy.dmitrij@braincode.xyz',
        '7951598',
        {
          user_name: @request.fullname,
          product_url: 'product_url',
          action_url: 'action_url',
          company_name: @request.company,
          company_address: 'address'
        }
      )
      render json: @request, status: :created
    else
      render json: @request.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @request
  end

  def update
    if @request.update(do_processed: true)
      CustomPostmarkMailer.template_email(
        'piskovoy.dmitrij@braincode.xyz',
        '7952090',
        {
          product_url: 'product_url_Value',
          user_name: @request.fullname,
          support_url: 'support_url_Value',
          company_name: @request.company,
          company_address: 'company_address_Value'
        }
      ).deliver_now
    end

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
      :industry, :city, :sector, :turnover, :markets, :tender_level, :win_rate,
      :number_public_contracts, :do_use_automation, :do_use_collaboration,
      :do_use_bid_no_bid, :do_use_bid_library, :do_use_feedback, :do_collaborate,
      :tender_complete_time, :organisation_count, :do_processed, :industry_id, :country_id
    )
  end
end