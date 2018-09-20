class Marketplace::BidNoBidQuestionSerializer < ActiveModel::Serializer
  attributes :id, :question_text, :position, :position
  has_one :tender
end
