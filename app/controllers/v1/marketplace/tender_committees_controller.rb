class V1::Marketplace::TenderCommitteesController < ApplicationController
  before_action :set_tender
  before_action :set_user, only: [:create, :destroy]
  # GET /marketplace/tender_committees
  def index
    @marketplace_tender_committees = @tender.committees.all

    render json: @marketplace_tender_committees, each_serializer: Marketplace::TenderCommitteeSerializer
  end

  # POST /marketplace/tender_committees
  def create
    @tender.transaction do 
      @tender.committees << @user
      render json: @marketplace_tender_committees, status: :created
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # DELETE /marketplace/tender_committees/1
  def destroy
    @tender.committees.delete(@user)
  end

  private
    def set_tender
      @tender = Core::Tender.find(params[:tender_id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end
end
