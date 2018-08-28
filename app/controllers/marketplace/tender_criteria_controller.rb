class Marketplace::TenderCriteriaController < ApplicationController
  before_action :set_marketplace_tender_criterium, only: [:show, :update, :destroy]

  # GET /marketplace/tender_criteria
  def index
    @marketplace_tender_criteria = Marketplace::TenderCriterium.all

    render json: @marketplace_tender_criteria
  end

  # GET /marketplace/tender_criteria/1
  def show
    render json: @marketplace_tender_criterium
  end

  # POST /marketplace/tender_criteria
  def create
    @marketplace_tender_criterium = Marketplace::TenderCriterium.new(marketplace_tender_criterium_params)

    if @marketplace_tender_criterium.save
      render json: @marketplace_tender_criterium, status: :created, location: @marketplace_tender_criterium
    else
      render json: @marketplace_tender_criterium.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /marketplace/tender_criteria/1
  def update
    if @marketplace_tender_criterium.update(marketplace_tender_criterium_params)
      render json: @marketplace_tender_criterium
    else
      render json: @marketplace_tender_criterium.errors, status: :unprocessable_entity
    end
  end

  # DELETE /marketplace/tender_criteria/1
  def destroy
    @marketplace_tender_criterium.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marketplace_tender_criterium
      @marketplace_tender_criterium = Marketplace::TenderCriterium.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def marketplace_tender_criterium_params
      params.require(:marketplace_tender_criterium).permit(:order, :title)
    end
end
