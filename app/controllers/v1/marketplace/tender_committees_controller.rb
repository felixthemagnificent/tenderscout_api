class V1::Marketplace::TenderCommitteesController < ApplicationController
  before_action :set_marketplace_tender_committee, only: [:show, :update, :destroy]

  # GET /marketplace/tender_committees
  def index
    @marketplace_tender_committees = Marketplace::TenderCommittee.all

    render json: @marketplace_tender_committees
  end

  # GET /marketplace/tender_committees/1
  def show
    render json: @marketplace_tender_committee
  end

  # POST /marketplace/tender_committees
  def create
    @marketplace_tender_committee = Marketplace::TenderCommittee.new(marketplace_tender_committee_params)

    if @marketplace_tender_committee.save
      render json: @marketplace_tender_committee, status: :created, location: @marketplace_tender_committee
    else
      render json: @marketplace_tender_committee.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /marketplace/tender_committees/1
  def update
    if @marketplace_tender_committee.update(marketplace_tender_committee_params)
      render json: @marketplace_tender_committee
    else
      render json: @marketplace_tender_committee.errors, status: :unprocessable_entity
    end
  end

  # DELETE /marketplace/tender_committees/1
  def destroy
    @marketplace_tender_committee.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marketplace_tender_committee
      @marketplace_tender_committee = Marketplace::TenderCommittee.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def marketplace_tender_committee_params
      params.require(:marketplace_tender_committee).permit(:tender_id, :user_id)
    end
end
