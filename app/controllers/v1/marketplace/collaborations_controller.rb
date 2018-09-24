class V1::Marketplace::CollaborationsController < ApplicationController
  include ActionController::Serialization
  before_action :set_collaboration, only: [:show, :update, :destroy]

  def index
    render json: []
  end

  def show
    render json: @collaboration
  end

  def create
    # TODO: add collaboration
    render json: nil
  end

  def update
    # result = UpdateProfile.call(profile: @profile, params: params, user: current_user)
    # if result.success?
    #   render json: result.profile
    # else
    #   render json: result.errors, status: result.code
    # end
  end

  def destroy
    # @profile.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_collaboration
    @collaboration = Collaboration.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def collaboration_params
    params.permit(:tender_id)
  end

end
