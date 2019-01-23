class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :profile
  has_many :childrens, class_name: 'Comment', foreign_key: "parent_id", dependent: :destroy
  has_and_belongs_to_many :attachments
  COMMENT_MODEL= {
      'tender_qualification_criteria' => 'Marketplace::TenderQualificationCriteria',
      'award_criterium' => 'Marketplace::TenderAwardCriterium',
      'bnb_question' => 'Marketplace::BidNoBidQuestion'
  }
end
