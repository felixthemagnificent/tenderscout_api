class CustomPostmarkMailer < PostmarkMailer::Base
  def template_email(email_to, template_id, model)
    mail(
      from: 'anton.rogachevskyi@braincode.xyz',
      to: email_to,
      template_id: template_id,
      template_model: model
    )
  end
end
