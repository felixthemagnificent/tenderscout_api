class BulkCreateCriteriaSections
  include Interactor

  def call
    Marketplace::TenderCriteriaSection.transaction do
      marketplace_tender_criteria_sections.each do |section|
        section = context.tender.criteria_sections.new(section)
        section.save!

        create_criteries(params: context.params.to_unsafe_h, section: section, parent: nil)
      end
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

  def marketplace_tender_criteria_sections
    context.params.permit(sections: [])
  end

  def marketplace_tender_criteria_section_params
    context.params.permit(:order, :title)
  end

  def marketplace_tender_criteria_params
    context.params.permit(:order, :title, :tender_id, criteries: [])
  end


end