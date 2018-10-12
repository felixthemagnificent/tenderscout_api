module AssignmentNotifier
  extend ActiveSupport::Concern

    def send_notice(assignment,criteria)
      user = User.find(assignment.user_id)
      profile = User.find(assignment.user_id).profiles.first
    CustomPostmarkMailer.template_email(
        user.email,
        Rails.configuration.mailer['templates']['assignment_invite'],
        {
            tender_name: criteria.section.tender.title,
            product_url: Rails.configuration.mailer['product_url'],
            user_name: profile.fullname,
            criteria_name: criteria.title,
            compete_status_url: '',
            support_url: Rails.configuration.mailer['support'],
            company_name: Rails.configuration.mailer['company_name'],
            company_address: Rails.configuration.mailer['company_address']
      }
    ).deliver_now
      end

  end