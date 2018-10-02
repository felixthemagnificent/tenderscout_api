class CreateTenderTaskAnswer
  include Interactor

  def call
    tender = Core::Tender.find(answer_params[:tender_id])
    unless tender.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Tender not found'},
                    code: :unprocessable_entity
    end
    if tender.tender_collaborators.exists?(context.user.id)
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Action not allowed'},
                    code: :unprocessable_entity
    end
    task = tender.tasks.where(id: tasks_params[:tender_task_id]).first
    unless task.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Task not found'},
                    code: :unprocessable_entity
    end

    unless answer_params[:pass_fail].present? || answer_params[:score].present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'No answer provided'},
                    code: :unprocessable_entity
    end

    if task.answers.exists?(closed: true)
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Answer is already closed'},
                    code: :unprocessable_entity
    end

    context.answer = task.answers.new(answer_params)
    context.answer.user = context.user

    unless context.answer.save
      context.fail! errors: context.answer.errors,
                    code: :unprocessable_entity
    end

    unless tender.buyers.exists?(context.user.id)
      tender.buyers << context.user
    end
  end

  private

  def tasks_params
    context.params.permit(:tender_task_id)
  end

  def answer_params
    context.params.permit(:tender_id, :pass_fail, :score, :closed)
  end
end