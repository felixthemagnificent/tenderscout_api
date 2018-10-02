class Marketplace::Compete::BidNoBidAnswerSerializer < ActiveModel::Serializer
  attributes :id, :answer_text, :comment
  has_one :bid_no_bid_answer
  has_one :bid_no_bid_question
end
