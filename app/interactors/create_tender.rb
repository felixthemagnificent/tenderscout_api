class CreateTender
  include Interactor

  def call
    Core::Tender.transaction do
      context.fail! errors: { error: :unauthorized, error_description: 'Action is not allowed'},
                      code: :unauthorized unless context.user.admin?

      context.tender = Core::Tender.new(tender_params)
      context.tender.estimated_low_value = params[:value_from] if params[:value_from]
      context.tender.estimated_high_value = params[:value_to] if params[:value_to]
      context.tender.industry = Industry.find(industry_params[:industry]) if industry_params
      context.tender.country = Core::Country.find(geography_params[:geography]) if geography_params
      context.fail! errors: context.tender.errors, code: :unprocessable_entity unless context.tender.save

      if contact_params
        contact = context.tender.contacts.new
        contact.contact_point = contact_params[:person]
        contact.email = contact_params[:email]
          context.fail! errors: contact.errors, code: :unprocessable_entity unless contact.save
      end
    end
  end

  private

  def tender_params
    context.params.permit(
      :title, :description, :submission_date, :dispatch_date, keywords: []
    )
  end

  def industry_params
    context.params.permit(:industry)
  end

  def geography_params
    context.params.permit(:geography)
  end

  def contact_params
    context.params[:contact_info]
  end

end