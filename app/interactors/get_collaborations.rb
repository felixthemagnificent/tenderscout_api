class GetCollaborations
  include Interactor

  def call
    tender = Core::Tender.where(id: index_params[:tender_id]).first
    unless tender.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Tender not found'},
                    code: :unprocessable_entity
    end

    users = []
    users = tender.collaboration_interests.map(&:user) if index_params[:interest] == 'true'
    context.results = []

    unless users.empty?
      case index_params[:type]
      when nil
        users.each { |user| generate_profile_array(user.profiles) }
      else
        users.each { |user| generate_profile_array(user.profiles.where(profile_type: index_params[:type])) }
      end
    end
  end

  private

  def index_params
    context.params.permit(:match, :interest, :type, :tender_id)
  end

  def generate_profile_array(profiles)
    profiles.each { |item| context.results.push(item) }
  end
end