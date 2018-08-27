class ProfileSerializer < ActiveModel::Serializer
  has_many :contacts, serializer: ContactSerializer
  has_many :keywords
  belongs_to :country, class_name: 'Core::Country', serializer: CountrySerializer
  belongs_to :industry, serializer: IndustrySerializer

  attributes :id, :fullname, :display_name, :avatar, :cover_img, :city,
             :do_marketplace_available, :profile_type, :company_size,
             :turnover, :timezone, :contacts, :keywords

  attribute(:role) { object.try(:role) }
end
