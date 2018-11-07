class V1::Marketplace::TenderQualificationCriteriaSectionsController < ApplicationController
  before_action :set_marketplace_tender_qualification_criteria_section, only: [:show, :update, :destroy]
  before_action :set_tender
  after_action :verify_authorized

  # GET /marketplace/tender_qualification_criteria_sections
  def index
    ::Marketplace::TenderQualificationCriteria.current_user_id(current_user.id)
    @marketplace_tender_qualification_criteria_sections = @tender.qualification_criteria_sections
    authorize @marketplace_tender_qualification_criteria_sections
    render json: @marketplace_tender_qualification_criteria_sections
  end

  # GET /marketplace/tender_qualification_criteria_sections/1
  def show
    authorize @marketplace_tender_qualification_criteria_section
    render json: @marketplace_tender_qualification_criteria_section
  end

  def bulk_create
    authorize ::Marketplace::TenderQualificationCriteriaSection
    result = BulkCreateQualificationCriteriaSections.call(params: params, tender: @tender)
    if result.success?
      render json: nil, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  # POST /marketplace/tender_qualification_criteria_sections
  def create
    @marketplace_tender_qualification_criteria_section = @tender.qualification_criteria_sections.new(marketplace_tender_qualification_criteria_section_params)
    authorize @marketplace_tender_qualification_criteria_section
    if @marketplace_tender_qualification_criteria_section.save
      render json: @marketplace_tender_qualification_criteria_section, status: :created
    else
      render json: @marketplace_tender_qualification_criteria_section.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /marketplace/tender_qualification_criteria_sections/1
  def update
    authorize @marketplace_tender_qualification_criteria_section
    if @marketplace_tender_qualification_criteria_section.update(marketplace_tender_qualification_criteria_section_params)
      render json: @marketplace_tender_qualification_criteria_section
    else
      render json: @marketplace_tender_qualification_criteria_section.errors, status: :unprocessable_entity
    end
  end

  # DELETE /marketplace/tender_qualification_criteria_sections/1
  def destroy
    authorize @marketplace_tender_qualification_criteria_section
    @marketplace_tender_qualification_criteria_section.destroy
  end

  private
    def set_tender
      @tender = Core::Tender.find(params[:tender_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_marketplace_tender_qualification_criteria_section
      @marketplace_tender_qualification_criteria_section = Marketplace::TenderQualificationCriteriaSection.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def marketplace_tender_qualification_criteria_section_params
      params.permit(:order, :title, :tender_id, :collaboration_id)
    end
end
