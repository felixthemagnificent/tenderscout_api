class V1::Users::UpgradeRequestsController < ApplicationController
	include ActionController::Serialization
	before_action :authenticate_user!
	before_action :set_user_upgrade_request, only: [:approve, :destroy]
	after_action :verify_authorized

  def index
  	authorize UserUpgradeRequest
  	render json: UserUpgradeRequest.all, each_serializer: ::Users::UpgradeRequestSerializer
  end

  def approve
  	authorize @uur
  	begin
	  	@uur.transaction do
		  	@uur.user.standart!
		  	@uur.updated_at = DateTime.now
		  	@uur.save!
		  end
		  render json: nil, status: :ok
		rescue
			render json: nil, status: :unprocessable_entity
		end
  end

  def destroy
  	authorize @uur
    if @uur.destroy
    	render json: nil, status: :ok
    else
    	render json: nil, status: :unprocessable_entity
    end
  end

  private
  def set_user_upgrade_request
  	@uur = UserUpgradeRequest.find(params[:id])
  end
end
