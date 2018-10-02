class BulkCreateTaskSections
  include Interactor

  def call
    Marketplace::TenderTaskSection.transaction do
      marketplace_tender_task_sections.each do |section|
        section_instance = context.tender.task_sections.new(title: section[:title], order: section[:order])
        section_instance.save!

        create_criteries(params: section, section: section_instance)
      end
    end
  end

  private

  def create_criteries(params: nil, section: nil)

    params[:tasks].each do |e|
      criteria = section.tasks.new(
        order: e[:order],
        title: e[:title],
        weight: e[:weight],
        )
      criteria.save!
    end
  end

  def marketplace_tender_task_sections
    context.params.to_unsafe_h[:sections]
  end

  def marketplace_tender_task_section_params
    context.params.permit(:order, :title, :weight)
  end

  def marketplace_tender_task_params
    context.params.permit(:order, :title, :weight, :tender_id, tasks: [])
  end


end