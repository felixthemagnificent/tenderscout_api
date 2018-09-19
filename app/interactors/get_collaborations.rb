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
      profiles = user.profiles
      profiles = profiles.where(profile_type: Profile.profile_types(index_params[:type])) unless index_params[:type]
      users.each { |user| generate_profile_array(profiles) }
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