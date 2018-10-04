class Comment < ApplicationRecord
  include ActiveModel::Serialization

  belongs_to :commentable, polymorphic: true
  belongs_to :profile
  has_many :childrens, class_name: 'Comment', foreign_key: "parent_id"

  COMMENT_MODEL= {
      'tender_task' => 'Marketplace::TenderTask',
      'award_criterium' => 'Marketplace::TenderAwardCriterium',
      'bnb_question' => 'Marketplace::BidNoBidQuestion'
  }
end
