class AssistanceSerializer < ActiveModel::Serializer
  attributes :id, :assistance_type, :status, :message,
             :user_id, :profile

  def profile
    object.try(:user).profiles.where(profile_type: :consultant).first
  end
end
