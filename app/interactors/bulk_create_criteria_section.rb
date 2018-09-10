class BulkCreateCriteriaSection
  include Interactor

  def call
    Marketplace::TenderCriteriaSection.transaction do

      section = context.tender.criteria_sections.new(marketplace_tender_criteria_section_params)
      section.save!

      create_criteries(params: context.params.to_unsafe_h, section: section, parent: nil)
    end
  end

  private

  def create_criteries(params: nil, section: nil, parent: nil)

    params[:criteries].each do |e|
      criteria = section.criteries.new(
        order: e[:order],
        title: e[:title],
        parent: parent
        )
      criteria.save!
      create_criteries(params: e, section: section, parent: criteria) if e[:criteries]
    end
  end

  def marketplace_tender_criteria_section_params
    context.params.permit(:order, :title)
  end

  def marketplace_tender_criteria_params
    context.params.permit(:order, :title, :tender_id, criteries: [])
  end

end