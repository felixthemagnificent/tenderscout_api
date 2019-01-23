class Note < ApplicationRecord
  belongs_to :notable, polymorphic: true
  belongs_to :profile
  has_and_belongs_to_many :attachments

  NOTES_MODEL= {
      'tender_qualification_criteria' => 'Marketplace::TenderQualificationCriteria',
      'award_criterium' => 'Marketplace::TenderAwardCriterium',
      'bnb_question' => 'Marketplace::BidNoBidQuestion'
  }
end
