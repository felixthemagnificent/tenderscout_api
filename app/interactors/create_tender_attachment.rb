class CreateTenderAttachment
  include Interactor

  def call
    # unless context.user.admin?
    #   context.fail! errors: { error: :unauthorized, error_description: 'Action is not allowed'},
    #                 code: :unauthorized
    # end

    unless context.tender.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Tender not found'},
                    code: :unprocessable_entity
    end

    if attachment_params
      attachment_params.each do |file|
        attachment = Attachment.new(file: file)
        context.fail! errors: attachment.errors, code: :unprocessable_entity unless attachment.save
        context.tender.attachments << attachment
      end
    end
  end

  private

  def attachment_params
    context.params[:files]
  end
end