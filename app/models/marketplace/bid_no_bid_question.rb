class Marketplace::BidNoBidQuestion < ApplicationRecord
  # belongs_to :tender
  has_many :bid_no_bid_answers, class_name: 'Marketplace::BidNoBidAnswer', dependent: :destroy
  has_many :bid_no_bid_compete_answers, class_name: 'Marketplace::Compete::BidNoBidAnswer', dependent: :destroy
  has_many :comments, as: :commentable
  has_many :notes, as: :notable

  def available_answers
    Marketplace::BidNoBidAnswer.where(bid_no_bid_question: self)
  end

  def answers
    Marketplace::Compete::BidNoBidAnswer.where(bid_no_bid_question: self)
  end

end
