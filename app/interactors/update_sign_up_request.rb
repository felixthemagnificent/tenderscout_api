class UpdateSignUpRequest
  include Interactor

  def call
    context.fail! errors: context.request.errors, code: :unprocessable_entity unless context.request.update(do_processed: true)
  end
end
