class GetCollaborations
  include Interactor

  def call
    tender = Core::Tender.where(id: index_params[:tender_id]).first
    unless tender.present?
      context.fail! errors: { error: :unprocessable_entity, error_description: 'Tender not found'},
                    code: :unprocessable_entity
    end

    profiles = []
    context.results = []

    profiles = tender.collaboration_interests.map(&:user).map(&:profiles).inject(&:+) if index_params[:interest] == 'true'
    if index_params[:match]
      profiles = BidsenseResult.where(tender: tender).where('average_score >= ?', 0.6).map(&:profile) - profiles
    end
    profiles = Profile.all unless profiles.any?
    profiles = profiles.where(profile_type: Profile.profile_types(index_params[:type])) if index_params[:type]
    users.each { |user| generate_profile_array(profiles) }
  end

  private

  def index_params
    context.params.permit(:match, :interest, :type, :tender_id)
  end

  def generate_profile_array(profiles)
    profiles.each { |item| context.results.push(item) }
  end
end