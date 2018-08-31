class Marketplace::TenderTaskSectionsController < ApplicationController
  before_action :set_marketplace_tender_task_section, only: [:show, :update, :destroy]

  # GET /marketplace/tender_task_sections
  def index
    @marketplace_tender_task_sections = Marketplace::TenderTaskSection.all

    render json: @marketplace_tender_task_sections
  end

  # GET /marketplace/tender_task_sections/1
  def show
    render json: @marketplace_tender_task_section
  end

  # POST /marketplace/tender_task_sections
  def create
    @marketplace_tender_task_section = Marketplace::TenderTaskSection.new(marketplace_tender_task_section_params)

    if @marketplace_tender_task_section.save
      render json: @marketplace_tender_task_section, status: :created, location: @marketplace_tender_task_section
    else
      render json: @marketplace_tender_task_section.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /marketplace/tender_task_sections/1
  def update
    if @marketplace_tender_task_section.update(marketplace_tender_task_section_params)
      render json: @marketplace_tender_task_section
    else
      render json: @marketplace_tender_task_section.errors, status: :unprocessable_entity
    end
  end

  # DELETE /marketplace/tender_task_sections/1
  def destroy
    @marketplace_tender_task_section.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marketplace_tender_task_section
      @marketplace_tender_task_section = Marketplace::TenderTaskSection.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def marketplace_tender_task_section_params
      params.require(:marketplace_tender_task_section).permit(:order, :title, :tender_id)
    end
end
