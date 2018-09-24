class Marketplace::BidNoBidQuestionSerializer < ActiveModel::Serializer
  attributes :id, :question_text, :order
  has_one :tender
end
