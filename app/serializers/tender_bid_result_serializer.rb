class TenderBidResultSerializer < ActiveModel::Serializer
  attributes :id, :estimate_score, :actual_score, :winning_score, :tender_award_criteria_id,
             :created_at, :updated_at
end