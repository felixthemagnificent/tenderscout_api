class CreateSignUpRequest
  include Interactor

  def call
    industry = Industry.find_by(id: request_params[:industry_id])
    unless industry.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Industry not found'},
                    code: :unprocessable_entity
    end
    country = Core::Country.find_by(id: request_params[:country_id])
    unless country.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Country not found'},
                    code: :unprocessable_entity
    end
    context.request = SignUpRequest.new(request_params)
    context.request.industry = industry
    context.request.country = country

    context.fail! errors: context.request.errors, code: :unprocessable_entity unless context.request.save


  end

  private

  def request_params
    context.params.permit(
        :fullname, :company, :state,
        :city, :tender_level, :email, :phone,
        :number_public_contracts, :tender_complete_time,
        :organisation_count, :industry_id, :country_id,
        markets: []
    )
  end

end
