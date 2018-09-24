class V1::Marketplace::TenderCriteriaAnswerController < ApplicationController
  def index
    render json: TenderCriteriaAnswer.where(tender_criteria_id: params[:tender_criterium_id]).where(user: current_user)
  end

  def create
    result = CreateCriteriaAnswer.call(params: answer_params, user: current_user)
    if result.success?
      render json: result.answer, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  def close
    result = CloseCriteriaAnswer.call(params: close_params, user: current_user)
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
    params.permit(:tender_criterium_id, :tender_id, :pass_fail, :score, :closed)
  end

  def close_params
    params.permit(:tender_criterium_id, :tender_id, :closed)
  end
end
