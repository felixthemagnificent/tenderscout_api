class SignUpRequest
  include Interactor

  def call
    industry = Industry.find(context.params[:industry_id])
    unless industry.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Industry not found'},
                    code: :unprocessable_entity
    end
    country = Country.find(context.params[:country_id])
    unless country.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Country not found'},
                    code: :unprocessable_entity
    end
    context.request = RegistrationRequest.new(context.params)
    context.request.do_processed = false
    context.request.industry = industry
    context.request.country = country

    context.fail! errors: context.request.errors, code: :unprocessable_entity unless context.request.save

    CustomPostmarkMailer.template_email(
      Rails.configuration.mailer['admin_email'],
      Rails.configuration.mailer['templates']['sign_up_request'],
      {
        user_name: context.request.fullname,
        product_url: Rails.configuration.mailer['product_url'],
        action_url: Rails.configuration.mailer['product_url'] + Rails.configuration.mailer['uri']['admin_sign_up'],
        company_name: Rails.configuration.mailer['company_name'],
        company_address: Rails.configuration.mailer['company_address']
      }
    ).deliver_now
  end
end
