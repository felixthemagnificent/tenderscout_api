class V1::Marketplace::TenderAwardCriteriaController < ApplicationController
  before_action :set_marketplace_tender_award_criterium, only: [:show, :update, :destroy]
  before_action :set_tender

  # GET /marketplace/tender_award_criteria
  def index
    @marketplace_tender_award_criteria = @tender.award_criteries

    render json: @marketplace_tender_award_criteria
  end

  # GET /marketplace/tender_award_criteria/1
  def show
    render json: @marketplace_tender_award_criterium
  end

  # POST /marketplace/tender_award_criteria
  def create
    @marketplace_tender_award_criterium = Marketplace::TenderAwardCriterium.new(marketplace_tender_award_criterium_params)

    if @marketplace_tender_award_criterium.save
      render json: @marketplace_tender_award_criterium, status: :created, location: @marketplace_tender_award_criterium
    else
      render json: @marketplace_tender_award_criterium.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /marketplace/tender_award_criteria/1
  def update
    if @marketplace_tender_award_criterium.update(marketplace_tender_award_criterium_params)
      render json: @marketplace_tender_award_criterium
    else
      render json: @marketplace_tender_award_criterium.errors, status: :unprocessable_entity
    end
  end

  # DELETE /marketplace/tender_award_criteria/1
  def destroy
    @marketplace_tender_award_criterium.destroy
  end

  private
    def set_tender
      @tender = Core::Tender.find_by_id params[:tender_id]
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_marketplace_tender_award_criterium
      @marketplace_tender_award_criterium = Marketplace::TenderAwardCriterium.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def marketplace_tender_award_criterium_params
      params.require(:marketplace_tender_award_criterium).permit(:order, :title, :description, :tender_award_criteria_section_id)
    end
end
