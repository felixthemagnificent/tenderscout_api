class CreateCompeteAnswer
  include Interactor

  def call


    @tender = Core::Tender.find(context.params[:tender_id])
    unless @tender.present?
      context.fail! errors: { error: :unauthorized, error_description: 'Tender not found'},
                    code: :unauthorized
    end
    @comment = CompeteComment.find(context.params[:id])
    unless @tender.present?
      context.fail! errors: { error: :unauthorized, error_description: 'Comment not found'},
                    code: :unauthorized
    end

    context.answer = CompeteAnswer.new(params)
    context.answer.user = context.user
    context.answer.compete_comment = @comment
    unless context.answer.save
      context.fail! errors: context.answer.errors,
                    code: :unprocessable_entity
    end
  end

  private

  def params
    context.params.permit(:message, :parent_id)
  end
end