class V1::Marketplace::TenderTasksController < ApplicationController
  before_action :set_marketplace_tender_task, only: [:show, :update, :destroy]

  # GET /marketplace/tender_tasks
  def index
    @marketplace_tender_tasks = Marketplace::TenderTask.all

    render json: @marketplace_tender_tasks
  end

  # GET /marketplace/tender_tasks/1
  def show
    render json: @marketplace_tender_task
  end

  # POST /marketplace/tender_tasks
  def create
    @marketplace_tender_task = Marketplace::TenderTask.new(marketplace_tender_task_params)

    if @marketplace_tender_task.save
      render json: @marketplace_tender_task, status: :created, location: @marketplace_tender_task
    else
      render json: @marketplace_tender_task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /marketplace/tender_tasks/1
  def update
    if @marketplace_tender_task.update(marketplace_tender_task_params)
      render json: @marketplace_tender_task
    else
      render json: @marketplace_tender_task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /marketplace/tender_tasks/1
  def destroy
    @marketplace_tender_task.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marketplace_tender_task
      @marketplace_tender_task = Marketplace::TenderTask.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def marketplace_tender_task_params
      params.require(:marketplace_tender_task).permit(:order, :title, :weight)
    end
end
