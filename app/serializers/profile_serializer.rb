class ProfileSerializer < ActiveModel::Serializer
  has_many :contacts, serializer: ContactSerializer
  attributes :id, :fullname, :display_name, :company, :timezone, :contacts
end
