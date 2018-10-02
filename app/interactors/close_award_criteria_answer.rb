class CloseAwardCriteriaAnswer
  include Interactor

  def call
    tender = Core::Tender.find(answer_params[:tender_id])
    unless tender.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Tender not found'},
                    code: :unprocessable_entity
    end
    if tender.collaborators.exists?(context.user.id)
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Action not allowed'},
                    code: :unprocessable_entity
    end
    award_criteria = tender.award_criteries.where(criteria_params[:tender_award_criteria_id]).first
    unless award_criteria.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Criteria not found'},
                    code: :unprocessable_entity
    end

    context.answer = award_criteria.answers.new(closed: true)
    context.answer.user = context.user

    unless context.answer.save
      context.fail! errors: context.answer.errors,
                    code: :unprocessable_entity
    end
  end

  private

  def criteria_params
    context.params.permit(:tender_award_criteria_id)
  end

  def answer_params
    context.params.permit(:tender_id)
  end
end