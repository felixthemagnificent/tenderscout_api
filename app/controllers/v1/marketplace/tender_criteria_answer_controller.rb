class V1::Marketplace::TenderAwardCriteriaAnswerController < ApplicationController
  def index
    render json: TenderAwardCriteriaAnswer.where(tender_criteria_id: params[:tender_award_criateria_id]).where(user: current_user)
  end

  def create
    result = CreateAwardCriteriaAnswer.call(params: answer_params, user: current_user)
    if result.success?
      render json: result.answer, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  def close
    result = CloseAwardCriteriaAnswer.call(params: close_params, user: current_user)
    if result.success?
      render json: result.answer, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def paginate_params
    params.permit(:page, :page_size)
  end

  def answer_params
    params.permit(:tender_award_criateria_id, :tender_id, :pass_fail, :score, :closed)
  end

  def close_params
    params.permit(:tender_award_criateria_id, :tender_id, :closed)
  end
end