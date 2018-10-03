class Note < ApplicationRecord
  belongs_to :notable, polymorphic: true
  belongs_to :user

  NOTES_MODEL= {
      'tender_task' => 'Marketplace::TenderTask',
      'award_criterium' => 'Marketplace::TenderAwardCriterium',
      'bnb_question' => 'Marketplace::BidNoBidQuestion'
  }
end
