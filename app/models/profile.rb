class Profile < ApplicationRecord
  has_many :contacts
  has_many :case_studies
  has_many :bidsense_results
  has_many :comments
  has_many :notes

  has_and_belongs_to_many :keywords
  has_and_belongs_to_many :countries, class_name: 'Core::Country'
  has_and_belongs_to_many :industries

  belongs_to :user
  belongs_to :country, class_name: 'Core::Country', optional: true
  belongs_to :industry, optional: true

  enum profile_type: [:consultant, :company]

  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover_img, CoverImgUploader

  validates_presence_of :fullname
  #:display_name, :timezone, :profile_type, :user_id
  #validates_presence_of :company_size, :turnover unless :profile_type != :consultant

  after_save :recalculate_bidsense

  def owner?(current_user)
    user == current_user
  end

  private
  def recalculate_bidsense
    Bidsense::RecalculateScoreJob.perform_later profile: self
  end
end
