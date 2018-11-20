class V1::AssistancesController < ApplicationController
  before_action :set_assistance, only: [:show]
  after_action :verify_authorized

  def index
    authorize Assistance
    assistances = Assistance.all
    assistances_paginated = assistances.my_paginate(paginate_params)
    render json: {
      data: ActiveModel::Serializer::CollectionSerializer.new(
        assistances_paginated, 
        each_serializer: AssistanceSerializer),
      count: assistances.count
    }
  end

  def show
    authorize @assistance
    render json: @assistance
  end

  def create
    authorize Assistance
    assistance = Assistance.new(assistance_params)
    if current_user.valid_password(params[:current_password]) && assistance.save
      render json: assistance, status: :created
    else
      render json: assistance.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_assistance
    @assistance = Assistance.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def assistance_params
    params.permit(:assistance_type, :message, :tender_id)
  end

  def paginate_params
    params.permit(:page, :page_size)
  end

end
