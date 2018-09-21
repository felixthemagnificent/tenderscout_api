class V1::Marketplace::TendersController < ApplicationController
  include ActionController::Serialization
  before_action :set_tender, only: [:show, :update, :destroy, :set_avatar, :destroy_avatar, :publish, :get_bnb_data,
                                    :process_bnb_data, :best_bidsense_profiles , :complete_organization_tenders_list]

  # GET /profiles
  def index
    tenders = Core::Tender.all
    # byebug
    @tenders = tenders.my_paginate(paginate_params)
    render json: { count: tenders.count, data: @tenders }, current_user: current_user
  end

  def get_bnb_data
    render json: @tender.get_bnb_data
  end

  def process_bnb_data
    @tender.process_bnb_data(params, current_user)
    answer = Marketplace::BidNoBidAnswer.find_by_id params[:answer_id]
    question = Marketplace::BidNoBidQuestion.find_by_id params[:question_id]
    if answer.bid_no_bid_question == question
      self.bid_no_bid_compete_answers.create!({
        bid_no_bid_answer: answer,
        bid_no_bid_question: question,
        user: current_user
        
        })
      render json: @tender.get_bnb_data
    else
      render json: nil, status: :unprocessable_entity
    end
  end

  # GET /profiles/1
  def show
    render json: @tender
  end

  # POST /profiles
  def create
    result = CreateTender.call(params: params, user: current_user)
    if result.success?
      render json: result.tender, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  # PATCH/PUT /profiles/1
  def update
    result = UpdateTender.call(tender: @tender, params: tender_params, user: current_user)
    if result.success?
      render json: result.tender, current_user: current_user
    else
      render json: result.errors, status: result.code
    end
  end

  # DELETE /profiles/1
  def destroy
    result = DestroyTender.call(tender: @tender, params: tender_params, user: current_user)
    if result.success?
      render json: nil, status: :ok
    else
      render json: result.errors, status: result.code
    end
  end

  def publish
    result = PublishTender.call(tender: @tender, user: current_user)
    if result.success?
      render json: nil, status: :ok
    else
      render json: result.errors, status: result.code
    end
  end

  def compete
    result = CompeteProcessingInfo.call(params: compete_params, user: current_user)
    render json: {
      complete: result.complete
    }
  end

  def best_bidsense_profiles
     bidsenses = @tender.matched_competitor_bidsense
     profiles = bidsenses.map(&:profile)
     render json: { profiles: profiles, bidsense: bidsenses }
  end

  def current_buyer_company_won_list
    render json: []
  end

  def complete_organization_tenders_list
    render json: @tender.organization.complete_tenders
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tender
    @tender = Core::Tender.find(params[:id])
  end

  def paginate_params
    params.permit(:page, :page_size)
  end

  def bnb_params
    params.permit(:answer_id, :question_id)
  end

  # Only allow a trusted parameter "white list" through.
  def tender_params
    params.permit(
      :title, :description, :industry, :geography, :value_from,
      :value_to, :keywords, :submission_date, :dispatch_date,
      contact_info: []
    )
  end

  def compete_params
    params.permit(:id)
  end
end
