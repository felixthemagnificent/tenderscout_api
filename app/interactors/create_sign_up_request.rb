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
    context.request = RegistrationRequest.new(request_params)
    context.request.do_processed = false
    context.request.industry = industry
    context.request.country = country

    context.fail! errors: context.request.errors, code: :unprocessable_entity unless context.request.save

    @user = User.new(user_params)
    context.fail! errors: context.request.errors, code: :unprocessable_entity unless @user.save
    @profile = @user.profiles.new(profile_params)
    @profile.country = country
    context.fail! errors: context.request.errors, code: :unprocessable_entity unless @profile.save

    @contacts =  @profile.contacts.new(contact_type: 'phone', value: contact_params[:phone])
    context.fail! errors: context.request.errors, code: :unprocessable_entity unless @contacts.save

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

  def user_params
    context.params.permit(:email ,:password)
  end

  def profile_params
    context.params.permit(:fullname, :city)
  end

  def contact_params
    context.params.permit(:phone)
  end
end
