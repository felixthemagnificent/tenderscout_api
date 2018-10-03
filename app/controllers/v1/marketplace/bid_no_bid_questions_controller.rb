class V1::Marketplace::BidNoBidQuestionsController < ApplicationController
  before_action :set_marketplace_bid_no_bid_question, only: [:show, :update, :destroy, :bid_no_bid_question_comments,
                                                             :bid_no_bid_question_notes]

  # GET /marketplace/bid_no_bid_questions
  def index
    @marketplace_bid_no_bid_questions = ::Marketplace::BidNoBidQuestion.all

    render json: @marketplace_bid_no_bid_questions
  end

  # GET /marketplace/bid_no_bid_questions/1
  def show
    render json: @marketplace_bid_no_bid_question
  end

  # POST /marketplace/bid_no_bid_questions
  def create
    @marketplace_bid_no_bid_question = Marketplace::BidNoBidQuestion.new(marketplace_bid_no_bid_question_params)

    if @marketplace_bid_no_bid_question.save
      render json: @marketplace_bid_no_bid_question, status: :created, location: @marketplace_bid_no_bid_question
    else
      render json: @marketplace_bid_no_bid_question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /marketplace/bid_no_bid_questions/1
  def update
    if @marketplace_bid_no_bid_question.update(marketplace_bid_no_bid_question_params)
      render json: @marketplace_bid_no_bid_question
    else
      render json: @marketplace_bid_no_bid_question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /marketplace/bid_no_bid_questions/1
  def destroy
    @marketplace_bid_no_bid_question.destroy
  end

  # Comments for TenderTask
  def bid_no_bid_question_comments
    result = @marketplace_bid_no_bid_question.comments
    render json: result
  end

  # Notes for TenderTask
  def bid_no_bid_question_notes
    result = @marketplace_bid_no_bid_question.notes
    render json: result
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_marketplace_bid_no_bid_question
    @marketplace_bid_no_bid_question = Marketplace::BidNoBidQuestion.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def marketplace_bid_no_bid_question_params
    params.permit(:question_text, :position, :tender_id)
  end
end
