class Note < ApplicationRecord
  belongs_to :notable, polymorphic: true
  belongs_to :profile
  belongs_to :tender, class_name: 'Core::Tender'


  NOTES_MODEL= {
      'tender_qualification_criteria' => 'Marketplace::TenderQualificationCriteria',
      'award_criterium' => 'Marketplace::TenderAwardCriterium',
      'bnb_question' => 'Marketplace::BidNoBidQuestion'
  }
end
