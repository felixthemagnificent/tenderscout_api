class CloseCriteriaAnswer
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
    criteria = tender.criteries.where(criteria_params[:tender_criterium_id]).first
    unless criteria.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Criteria not found'},
                    code: :unprocessable_entity
    end

    context.answer = criteria.answers.new(closed: true)
    context.answer.user = context.user

    unless context.answer.save
      context.fail! errors: context.answer.errors,
                    code: :unprocessable_entity
    end
  end

  private

  def criteria_params
    context.params.permit(:tender_criterium_id)
  end

  def answer_params
    context.params.permit(:tender_id)
  end
end