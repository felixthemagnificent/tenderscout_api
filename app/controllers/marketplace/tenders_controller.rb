class Marketplace::TendersController < ApplicationController
  include ActionController::Serialization
  before_action :set_tender, only: [:show, :update, :destroy, :set_avatar, :destroy_avatar]

  # GET /profiles
  def index
    @tenders = Core::Tender.all.paginate(paginate_params)
    render json: @tenders
  end

  # GET /profiles/1
  def show
    render json: @tender
  end

  # POST /profiles
  def create
    result = CreateTender.call(params: tender_params, user: current_user)
    if result.success?
      render json: result.tender, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  # PATCH/PUT /profiles/1
  def update
    result = UpdateTender.call(tender: @tender, params: tender_params, user: current_user)
    if result.success?
      render json: result.tender
    else
      render json: result.errors, status: result.code
    end
  end

  # DELETE /profiles/1
  def destroy
    result = DestroyTender.call(tender: @tender, params: tender_params, user: current_user)
    if result.success?
      render json: nil, status: :ok
    else
      render json: result.errors, status: result.code
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tender
    @tender = Core::Tender.find(params[:id])
  end

  def paginate_params
    params.permit(:page, :page_size)
  end

  # Only allow a trusted parameter "white list" through.
  def tender_params
    params.permit(
      :title, :description, :industry, :geography, :value_from,
      :value_to, :keywords, :submission_date, :dispatch_date,
      contact_info: []
    )
  end
end
