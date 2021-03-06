class V1::Marketplace::CollaborationsController < ApplicationController
  include UserTenderStatusChanger
  before_action :set_tender
  before_action :set_marketplace_collaboration, only: [:accept, :ignore]
  after_action :verify_authorized, except: [:index, :accept, :ignore]
  # before_action :set_marketplace_collaboration, only: [:show, :update, :destroy]
  # GET /marketplace/collaborations
  def index
    @marketplace_collaborations = @tender.collaborations

    render json: @marketplace_collaborations
  end
 
  def accept
    @marketplace_collaboration.tender_collaborators.where(user: current_user).first.active!
    render json: nil, status: :ok
  end

  def ignore
    @marketplace_collaboration.tender_collaborators.where(user: current_user).first.ignore!
    render json: nil, status: :ok
  end

  # POST /marketplace/collaborations
  def apply
    @user = User.find_by_id params[:user_id]
    role = params[:role]
    @marketplace_collaboration = nil
    Marketplace::Collaboration.transaction do
      begin
        @marketplace_collaboration = ::Marketplace::Collaboration.find_by_id(params[:collaboration_id]) || @tender.collaborations.create
        authorize @marketplace_collaboration
        collaboration_status = (role == 'owner') ? :active : :pending
        @marketplace_collaboration.tender_collaborators.create(
          user: @user,
          role: role,
          status: collaboration_status,
          invited_by_user: current_user
        )
        @marketplace_collaboration.save!
        
        add_collaboration_to_user_status(@user, @tender, @marketplace_collaboration)
        render json: @marketplace_collaboration
      rescue
        render json: @marketplace_collaboration.errors, status: :unprocessable_entity
      end
    end
  end

  def remove
    user = User.find_by_id params[:user_id]
    @marketplace_collaboration = ::Marketplace::Collaboration.find_by_id(params[:collaboration_id])
    authorize @marketplace_collaboration
    @marketplace_collaboration.tender_collaborators.where(user: user).destroy_all
    @marketplace_collaboration.destroy if @marketplace_collaboration.tender_collaborators.count == 0

    render json: nil
  end

  # DELETE /marketplace/collaborations/1
  def destroy
    @marketplace_collaboration.destroy
  end

  private
    def set_tender
      @tender = Core::Tender.find(params[:tender_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_marketplace_collaboration
      @marketplace_collaboration = Marketplace::Collaboration.find_by_id(params[:collaboration_id]) || Marketplace::Collaboration.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def marketplace_collaboration_params
      params.permit(:tender_id, :user_id)
    end
end
