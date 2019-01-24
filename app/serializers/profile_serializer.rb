class ProfileSerializer < ActiveModel::Serializer
  has_many :contacts, serializer: ContactSerializer
  has_many :keywords
  has_many :countries, class_name: 'Core::Country', serializer: CountrySerializer
  has_many :industries, serializer: IndustrySerializer
  belongs_to :country, class_name: 'Core::Country', serializer: CountrySerializer
  belongs_to :industry, serializer: IndustrySerializer

  attributes :id, :fullname, :display_name, :avatar, :cover_img, :city,
             :profile_type, :company, :company_size,
             :valueFrom, :valueTo, :turnover, :timezone, :tender_level,
             :industry, :industries, :country, :description,
             :number_public_contracts, :contacts, :keywords, :countries, 
             :profile_type

  attribute(:values) { [object.try(:valueFrom), object.try(:valueTo)] }
  attribute(:user_id) { object.try(:user).try(:id) }
  attribute(:do_marketplace_available) { object.try(:user).try(:available?) }
  attribute(:role) { object.try(:user).try(:role) }
  attribute(:email) { object.try(:user).try(:email) }
end
