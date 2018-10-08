class V1::Marketplace::TenderAwardCriteriaController < ApplicationController
  before_action :set_marketplace_tender_award_criterium, only: [:show, :update, :destroy, :tender_award_criteria_comments,
                                                                :tender_award_criteria_notes, :update_deadline]
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
    @marketplace_tender_award_criterium = @tender.award_criteries.new(marketplace_tender_award_criterium_params)

    if @marketplace_tender_award_criterium.save
      render json: @marketplace_tender_award_criterium, status: :created
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

  # Comments for TenderAwardCriteries
  def tender_award_criteria_comments
    profiles = @marketplace_tender_award_criterium.comments.map(&:profile).uniq
    comments = ActiveModel::Serializer::CollectionSerializer.new(@marketplace_tender_award_criterium.comments,
                                                                 each_serializer: CommentSerializer)
    render json: { comments: comments, profiles: profiles }
  end

  # Notes for TenderAwardCriteries
  def tender_award_criteria_notes
    profiles = @marketplace_tender_award_criterium.notes.map(&:profile).uniq
    notes = ActiveModel::Serializer::CollectionSerializer.new(@marketplace_tender_award_criterium.notes,
                                                              each_serializer: NoteSerializer)
    render json: { notes: notes, profiles: profiles }
  end

  #Update dedline
  def update_deadline
    if @marketplace_tender_award_criterium.update(deadline_params)
      render json: @marketplace_tender_award_criterium
    else
      render json: @marketplace_tender_award_criterium.errors, status: :unprocessable_entity
    end
  end

  private
  def set_tender
    @tender = Core::Tender.find_by_id params[:tender_id]
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_marketplace_tender_award_criterium
    @marketplace_tender_award_criterium = ::Marketplace::TenderAwardCriterium.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def marketplace_tender_award_criterium_params
    params.permit(:order, :title, :description, :weight, :section_id)
  end

  def deadline_params
    params.permit(:deadline)
  end
end
