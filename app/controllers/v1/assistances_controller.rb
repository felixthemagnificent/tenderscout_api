class V1::AssistancesController < ApplicationController
  before_action :set_assistance, only: [:show]
  after_action :verify_authorized

  def index
    authorize Assistance
    render json: Assistance.all
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
    params.permit(:assistance_type, :message)
  end
end
