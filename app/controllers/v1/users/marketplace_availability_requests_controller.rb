class V1::Users::MarketplaceAvailabilityRequestsController < ApplicationController
  include ActionController::Serialization
  before_action :authenticate_user!
  before_action :set_marketplace_availability_request, only: [:approve, :destroy]
  after_action :verify_authorized

  def index
    authorize UserUpgradeRequest
    render json: UserMarketplaceAvailabilityRequest.all, each_serializer: ::Users::UpgradeRequestSerializer
  end

  def approve
    authorize @user_marketplace_availability_request
    @user_marketplace_availability_request.user.available!
    @user_marketplace_availability_request.upgraded_at = DateTime.now
    if @user_marketplace_availability_request.save
      render json: nil, status: :ok
    else
      render json: nil, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @user_marketplace_availability_request
    if @user_marketplace_availability_request.destroy
      render json: nil, status: :ok
    else
      render json: nil, status: :unprocessable_entity
    end
  end

  private
  def set_marketplace_availability_request
    @user_marketplace_availability_request = UserMarketplaceAvailabilityRequest.find(params[:id])
  end
end
