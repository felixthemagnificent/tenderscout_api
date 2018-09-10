class BulkCreateCriteriaSection
  include Interactor

  def call
    Marketplace::TenderCriteriaSection.transaction do
      context.fail! errors: { error: :unauthorized, error_description: 'Action is not allowed'},
                      code: :unauthorized unless context.user.admin?

      section = context.tender.criteria_sections.new(marketplace_tender_criteria_section_params)
      section.save!

      create_criteries(marketplace_tender_criteria_params)
      
    end
  end

  private

  def create_criteries(params: nil, parent: nil)
    params[:criteries].each do |e|
      criteria = section.criteries.create(
        order: e[:order],
        title: e[:title],
        parent: parent
        )
      create_criteries(params: e[:criteries], parent: criteria) if e[:criteries]
    end
    section.criteries.create(order: order, )
  end

  def marketplace_tender_criteria_section_params
    context.params.permit(:order, :title)
  end

  def marketplace_tender_criteria_params
    context.params.permit(:order, :title, :tender_id, criteries: [])
  end

end