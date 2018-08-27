class PostmarkMailer < PostmarkMailer::Base

  def send_template(send_to, subject, template, params)
    mail(
      from: 'from@example.com',
      to: send_to,
      subject: subject,
      template_alias: template,
      template_model: params
    )
  end
end