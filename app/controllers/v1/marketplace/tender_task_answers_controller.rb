class V1::Marketplace::TenderTaskAnswersController < ApplicationController
  def index #TODO move TenderTask model Marketplace::TenderTask
    render json: ::Marketplace::TenderTaskAnswer.where(tender_task_id: params[:tender_task_id]).where(user: current_user)
  end

  def create
    result = CreateTenderTaskAnswer.call(params: answer_params, user: current_user)
    if result.success?
      render json: result.answer, status: :created
    else
      render json: result.errors, status: result.code
    end
  end

  def close
    result = CloseTenderTaskAnswer.call(params: close_params, user: current_user)
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
    params.permit(:tender_task_id, :tender_id, :pass_fail, :score, :closed)
  end

  def close_params
    params.permit(:id, :tender_task_id, :tender_id, :closed)
  end
end
