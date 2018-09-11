class V1::AssistancesController < ApplicationController
  before_action :set_assistance, only: [:show]
  before_action :set_user

  def index
    render json: Assistance.all
  end

  def show
    render json: @assistance
  end

  def create
    @assistance = Assistance.new(assistance_params)

    if @assistance.save
      render json: @assistance, status: :created
    else
      render json: @assistance.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:user_id])
  end

  def set_assistance
    @assistance = Assistance.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def assistance_params
    params.permit(:assistance_type, :message, :user_id)
  end
end
