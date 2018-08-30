class InviteSupplier
  include Interactor

  def call
    # TODO check if is owner
    unless context.user.admin?
      context.fail! errors: { error: :unauthorized, error_description: 'Action is not allowed'},
                    code: :unauthorized
    end

    unless context.tender.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Tender not found'},
                    code: :unprocessable_entity
    end

    user = User.find_by_email(context.params[:supplier])
    unless user.present?
      profile = Profile.find_by_fullname(context.params[:supplier])
      user = profile.user if profile.present?
    end

    unless user.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'No user found'},
                    code: :unprocessable_entity
    end

    context.supplier = Supplier.new(
      status: :pending,
      tender: context.tender,
      user: user
    )

    unless context.supplier.save
      context.fail! errors: context.supplier.errors,
                    code: :unprocessable_entity
    end
  end
end