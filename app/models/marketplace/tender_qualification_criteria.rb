class Marketplace::TenderQualificationCriteria < ApplicationRecord
  belongs_to :section, class_name: 'Marketplace::TenderQualificationCriteriaSection', foreign_key: :section_id
  has_many :answers, class_name: 'Marketplace::TenderQualificationCriteriaAnswer', foreign_key: :tender_qualification_criteria_id, dependent: :destroy
  has_many :comments, as: :commentable
  has_many :notes, as: :notable
  has_many :assignments, class_name: 'Marketplace::Assignment', as: :assignable
  attr_accessor :user_id
  @@current_user_id = nil
  def user_id
    @@current_user_id
  end
  def self.current_user_id(user_id)
    @@current_user_id = user_id
  end
  include Assignable
end
