class V1::RegirstrationRequestsController < ApplicationController
  before_action :set_request, only: [:show, :update]

  def index
    render json: RegistrationRequest.all
  end

  def create
    @request = RegistrationRequest.new(request_params)
    @request.do_processed = false

    if @request.save
      # TODO send email
      render json: @request, status: :created
    else
      render json: @request.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @request
  end

  def update
    @request.update(do_processed: !@request.do_processed)
    # TODO send email
    render json: @request
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = RegistrationRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_params
    params.permit(:fullname, :company, :company_size, :state, :country, :city, :sector,
      :turnover, :markets, :tender_level, :win_rate, :number_public_contracts, :do_use,
      :do_collaborate, :tender_complete_time, :organisation_count, :do_processed
    )
  end
end