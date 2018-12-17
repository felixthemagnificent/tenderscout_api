class V2::Marketplace::CollaborationInterestsController < ApplicationController
  include ActionController::Serialization
  # after_action :verify_authorized
  before_action :set_collaboration_interest, only: [:show, :destroy]
  before_action :set_tender

  def index
    collaborations = GetCollaborations.call(params: index_params, user: current_user)
    result = []
    collaborations.results.map do |e| 
      is_collaborated = false
      collaboration = Marketplace::Collaboration.where(tender: @tender).try(:first)
      is_collaborated = true if collaboration && @tender.tender_collaborators.where(user: current_user).count > 0
      result << {
        is_collaborated: is_collaborated,
        is_tender_owner: (@tender.creator == current_user),
        profile: ProfileSerializer.new(e)
      }
    end
    render json: result
  end

  def show
    render json: @collaboration_interest
  end

  def create
    result = CreateInterestToCollaborate.call(params: interest_params, user: current_user)
    if result.success?
      render json: nil, status: :created
    else
      render json: result.errors, status: result.code
    end
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
  def set_collaboration_interest
    @collaboration_interest = CollaborationInterest.find(params[:id])
  end

  def set_tender
    @tender = Core::Tender.find(params[:tender_id])
  end

  # Only allow a trusted parameter "white list" through.
  def index_params
    params.permit(:match, :interest, :type, :tender_id)
  end

  def interest_params
    params.permit(:current_password, :message, :is_public, :tender_id)
  end
end
