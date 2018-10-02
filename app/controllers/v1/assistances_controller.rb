class V1::AssistancesController < ApplicationController
  before_action :set_assistance, only: [:show]

  def index
    render json: Assistance.all
  end

  def show
    render json: @assistance
  end

  def create
    result = CreateAssistanceRequest.call(params: assistance_params, user: current_user)
    if result.success?
      render json: result.assistance, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_assistance
    @assistance = Assistance.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def assistance_params
    params.permit(:assistance_type, :message, :current_password)
  end
end
