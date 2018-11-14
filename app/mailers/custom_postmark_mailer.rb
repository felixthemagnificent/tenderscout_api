class CustomPostmarkMailer < PostmarkMailer::Base
  def template_email(email_to, template_id, model)
    mail(
      From: Rails.configuration.mailer['from'],
      To: email_to,
      TemplateId: template_id,
      TemplateModel: model
    )
  end
end
