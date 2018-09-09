class BulkCreateCriteriaSection
  include Interactor

  def call
    Marketplace::TenderCriteriaSection.transaction do
      context.fail! errors: { error: :unauthorized, error_description: 'Action is not allowed'},
                      code: :unauthorized unless context.user.admin?

      criteria_section_params.each do |csp|
        CreateCriteriaSection.call(tender:context.tender, params: csp)
      end
    end
  end

  private

  def criteria_section_params
    context.params.permit(sections: [])
  end

end