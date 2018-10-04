class V1::Marketplace::TenderTasksController < ApplicationController
  include ActionController::Serialization
  before_action :set_marketplace_tender_task, only: [:show, :update, :destroy, :tender_task_comments, :tender_task_notes]
  before_action :set_tender
  # GET /marketplace/tender_tasks
  def index
    @marketplace_tender_tasks = @tender.tasks.all

    render json: @marketplace_tender_tasks
  end

  # GET /marketplace/tender_tasks/1
  def show
    render json: @marketplace_tender_task
  end

  # POST /marketplace/tender_tasks
  def create
    @marketplace_tender_task = @tender.tasks.new(marketplace_tender_task_params)

    if @marketplace_tender_task.save
      render json: @marketplace_tender_task, status: :created
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

  # Comments for TenderTask
  def tender_task_comments
    profiles = @marketplace_tender_task.comments.map(&:profile).uniq
    comments = ActiveModel::Serializer::CollectionSerializer.new(@marketplace_tender_task.comments,
                                                                 each_serializer: CommentSerializer)
    render json: { comments: comments, profiles: profiles }
  end

  # Notes for TenderTask
  def tender_task_notes
    profiles = @marketplace_tender_task.notes.map(&:profile).uniq
    notes = ActiveModel::Serializer::CollectionSerializer.new(@marketplace_tender_task.notes,
                                                              each_serializer: NoteSerializer)
    render json: { comments: notes, profiles: profiles }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marketplace_tender_task
      @marketplace_tender_task = ::Marketplace::TenderTask.find(params[:id])
    end


    def set_tender
      @tender = Core::Tender.find(params[:tender_id])
    end

    # Only allow a trusted parameter "white list" through.
    def marketplace_tender_task_params
      params.permit(:order, :title, :weight,:description, :section_id)
    end
end
