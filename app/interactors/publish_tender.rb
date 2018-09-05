class PublishTender
  include Interactor

  def call
    unless context.tender.owner?(context.user)
      context.fail! errors: { error: :unauthorized, error_description: 'Action is not allowed'},
                    code: :unauthorized
    end
    unless context.tender.title.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'No Title'},
                    code: :unprocessable_entity
    end
    unless context.tender.description.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'No Desription'},
                    code: :unprocessable_entity
    end
    unless context.tender.country.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'No Country'},
                    code: :unprocessable_entity
    end
    unless context.tender.industry.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'No Industry'},
                    code: :unprocessable_entity
    end
    unless context.tender.criteries.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'You should have at least one criteria'},
                    code: :unprocessable_entity
    end
    unless context.tender.criteria_sections.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'You should have at least one section'},
                    code: :unprocessable_entity
    end
    unless context.tender.awards.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'You should have at least one award'},
                    code: :unprocessable_entity
    end
    unless context.tender.submission_date > Date.now
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Submission date is incorrect'},
                    code: :unprocessable_entity
    end
    unless context.tender.submission_date < context.tender.dispatch_date
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Dispatch date is incorrect'},
                    code: :unprocessable_entity
    end
    unless context.tender.contacts.first.contact_point.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Contact person is not specified'},
                    code: :unprocessable_entity
    end
    unless context.tender.contacts.first.email.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Contact email is not specified'},
                    code: :unprocessable_entity
    end
  end
end