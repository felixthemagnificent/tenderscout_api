class V1::Marketplace::CollaborationsController < ApplicationController
  before_action :set_tender
  before_action :set_marketplace_collaboration, only: [:accept, :ignore]
  after_action :verify_authorized, except: [:index, :accept, :ignore]
  # before_action :set_marketplace_collaboration, only: [:show, :update, :destroy]
  # GET /marketplace/collaborations
  def index
    @marketplace_collaborations = @tender.collaborations.active

    render json: @marketplace_collaborations
  end
 
  def accept
    @marketplace_collaboration.accept!
    render json: nil, status: :ok
  end

  def ignore
    @marketplace_collaboration.ignore!
    render json: nil, status: :ok
  end

  # POST /marketplace/collaborations
  def apply
    user = User.find_by_id params[:user_id]
    role = params[:role]
    ::Marketplace::Collaboration.all.each do |e|  
      e.tender_collaborators.where(user: user).destroy_all
    end
    ::Marketplace::Collaboration.all.each do |e|  
      e.destroy unless e.tender_collaborators.count > 0
    end
    @marketplace_collaboration = ::Marketplace::Collaboration.find_by_id(params[:collaboration_id]) || @tender.collaborations.create
    authorize @marketplace_collaboration

    @marketplace_collaboration.tender_collaborators.create(
      user: user, 
      role: role, 
      status: :pending,
      invited_by_user: current_user
    )
    @marketplace_collaboration.valid?
    p @marketplace_collaboration.errors.full_messages
    p @marketplace_collaboration.tender_collaborators.first.errors.full_messages

    if @marketplace_collaboration.save
      CustomPostmarkMailer.template_email(
        context.supplier.user.email,
        Rails.configuration.mailer['templates']['collaboration_invite'],
        {
          user_name: current_user.profiles.first.fullname,
          tender_name: @tender.title,
          tender_id: @tender.id,
          tender_details_url: Rails.configuration.mailer['uri']['tender_details'],
          invite_link_url: '',
          product_url: Rails.configuration.mailer['product_url'],
          support_url: Rails.configuration.mailer['support'],
          company_name: Rails.configuration.mailer['company_name'],
          company_address: Rails.configuration.mailer['company_address']
        }
      ).deliver_now
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
