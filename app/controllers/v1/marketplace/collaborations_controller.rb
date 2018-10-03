class V1::Marketplace::CollaborationsController < ApplicationController
  before_action :set_tender
  # before_action :set_marketplace_collaboration, only: [:show, :update, :destroy]

  # GET /marketplace/collaborations
  def index
    @marketplace_collaborations = @tender.collaborations

    render json: @marketplace_collaborations
  end

 
  # POST /marketplace/collaborations
  def apply
    user = User.find_by_id params[:user_id]
    ::Marketplace::Collaboration.all.each do |e|  
      e.tender_collaborators.where(user: user).destroy_all
    end
    ::Marketplace::Collaboration.all.each do |e|  
      e.destroy unless e.tender_collaborators.count > 0
    end

    @marketplace_collaboration = ::Marketplace::Collaboration.find_by_id(params[:collaboration_id]) || @tender.collaborations.create
    @marketplace_collaboration.tender_collaborators.create(user: user)

    if @marketplace_collaboration.save
      render json: @marketplace_collaboration, status: :created
    else
      render json: @marketplace_collaboration.errors, status: :unprocessable_entity
    end
  end

  def remove
    user = User.find_by_id params[:user_id]
    ::Marketplace::Collaboration.all.each do |e|  
      e.tender_collaborators.where(user: user).destroy_all
    end

    ::Marketplace::Collaboration.all.each do |e|  
      e.destroy unless e.tender_collaborators.count > 0
    end
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
      @marketplace_collaboration = Marketplace::Collaboration.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def marketplace_collaboration_params
      params.permit(:tender_id, :user_id)
    end
end
