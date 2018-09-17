class Marketplace::BidNoBidAnswerSerializer < ActiveModel::Serializer
  attributes :id, :answer_text, :position
  has_one :bid_no_bid_question
end
