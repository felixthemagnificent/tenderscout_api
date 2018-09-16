class GetCollaborations
  include Interactor

  def call
    tender = Core::Tender.where(id: index_params[:tender_id]).first
    unless tender.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Tender not found'},
                    code: :unprocessable_entity
    end

    context.results = Profile.all

    if index_params[:match]
    end

    context.results = context.results.where(profile_type: 'company') if index_params[:type] == 'company'
  end

  private

  def index_params
    context.params.permit(:match, :interest, :type, :tender_id)
  end
end