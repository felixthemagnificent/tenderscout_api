class BulkCreateCriteriaSection
  include Interactor

  def call
    Marketplace::TenderCriteriaSection.transaction do
      context.fail! errors: { error: :unauthorized, error_description: 'Action is not allowed'},
                      code: :unauthorized unless context.user.admin?

      section = context.tender.criteries.new(marketplace_tender_criteria_section_params)
      section.save!

      context.params.criteries
      
    end
  end

  private

  def create_criteria
  end

  def marketplace_tender_criteria_section_params
    context.params.permit(:order, :title)
  end

  def marketplace_tender_criteria_section_params
    context.params.permit(:order, :title, :tender_id, criteries: [])
  end

end