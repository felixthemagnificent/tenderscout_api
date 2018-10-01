class V1::CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  COMMENT_MODEL= {
      'tender_task' => 'Marketplace::TenderTask',
      'award_criterium' => 'Marketplace::TenderAwardCriterium',
      'bnb_question' => 'Marketplace::BidNoBidQuestion'
  }


  def create
    if COMMENT_MODEL.key?(params[:commentable_type])
      coment_model = COMMENT_MODEL[params[:commentable_type]]
    else
      render json: {error: 'Unvalid commentable type'}
      return false
    end
    @comment = Comment.new(comment_params)
    @comment.commentable_type = coment_model
    @comment.user_id = current_user.id
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end

  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.permit(:body, :commentable_id, :commentable_type )
  end

end