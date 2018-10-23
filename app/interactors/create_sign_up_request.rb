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

    user = User.new(user_params)
    context.fail! errors: context.request.errors, code: :unprocessable_entity unless user.save
    profile = user.profiles.new(profile_params)
    profile.country = country
    context.fail! errors: context.request.errors, code: :unprocessable_entity unless profile.save
    #confirmation_url = 'http://localhost:3000/users/confirmation?confirmation_token=' + @raw_confirmation_token
    #confirmation_url = context.request.base_url + '/users/confirmation?confirmation_token' + @user.confirmation_token
    #p('ssssssssssssssssssssssssssssssssssssssss')
    #p(confirmation_url)
    #p('ssssssssssssssssssssssssssssssssssssssss')
    # CustomPostmarkMailer.template_email(
    #     self.email,
    #     ActionController::Base::Rails.configuration.mailer['templates']['assignment_invite'],
    #     {
    #         product_url: Rails.configuration.mailer['product_url'],
    #         user_name: @profile.fullname,
    #         activation_link: "activation_link_Value",
    #         support_url: Rails.configuration.mailer['support'],
    #         company_name: Rails.configuration.mailer['company_name'],
    #         company_address: Rails.configuration.mailer['company_address']
    #     }
    # )#.deliver_now

  end

  private

  def request_params
    context.params.permit(
        :fullname, :company, :company_size, :state,
        :city, :turnover, :tender_level, :win_rate, :email, :phone,
        :number_public_contracts, :do_use_automation, :do_use_collaboration,
        :do_use_bid_no_bid, :do_use_bid_library, :do_use_feedback, :do_collaborate,
        :tender_complete_time, :organisation_count, :industry_id, :country_id,
        markets: []
    )
  end

  def user_params
    context.params.permit(:email ,:password)
  end

  def profile_params
    context.params.permit(:fullname, :city)
  end
end
