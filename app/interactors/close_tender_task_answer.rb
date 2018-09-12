class CloseTenderTaskAnswer
  include Interactor

  def call
    tender = Core::Tender.find(answer_params[:tender_id])
    unless tender.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Tender not found'},
                    code: :unprocessable_entity
    end

    if tender.owner?(context.user) || tender.committees.exists?(context.user.id)
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Action not allowed'},
                    code: :unprocessable_entity
    end

    task = tender.tasks.where(context.params[:tender_task_id]).first
    unless task.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Task not found'},
                    code: :unprocessable_entity
    end

    context.answer = task.answers.new(closed: true)
    context.answer.user = context.user

    unless context.answer.save
      context.fail! errors: context.answer.errors,
                    code: :unprocessable_entity
    end
  end

  private

  def answer_params
    context.params.permit(:tender_id)
  end
end