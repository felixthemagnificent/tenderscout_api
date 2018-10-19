class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :profile
  belongs_to :tender, class_name: 'Core::Tender'
  has_many :childrens, class_name: 'Comment', foreign_key: "parent_id", dependent: :destroy

  COMMENT_MODEL= {
      'tender_qualification_criteria' => 'Marketplace::TenderQualificationCriteria',
      'award_criterium' => 'Marketplace::TenderAwardCriterium',
      'bnb_question' => 'Marketplace::BidNoBidQuestion'
  }
end
