class Marketplace::BidNoBidDeadline < ApplicationRecord
  belongs_to :marketplace_bid_no_bid_question, :class_name => 'Marketplace::BidNoBidQuestion', foreign_key: :bid_no_bid_question_id
  before_validation :check_available, on: :create

  private

  def check_available
    if Marketplace::BidNoBidDeadline.where(bid_no_bid_question_id: bid_no_bid_question_id, collaboration_id: collaboration_id).present?
      errors.add(:error, 'Assignment is already exist')
    end
  end
end