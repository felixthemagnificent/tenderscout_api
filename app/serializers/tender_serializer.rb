class TenderSerializer < ActiveModel::Serializer
  attributes  :id, :title, :description, :published_on, :awarded_on, :submission_date, :deadline_date,
              :cancelled_on, :procedure_id, :procedure_name, :currency_id, :currency_name, :organization_id, :organization_name,
              :status_cd, :contract_authority_type, :main_activity, :contract_category, :location, :flagged_as_sme_friendly, 
              :flagged_as_vcs_friendly, :nuts_codes, :supplementary_codes, :contract_duration_in_days, 
              :contract_duration_in_months, :contract_duration_in_years, :contract_start_date, 
              :contract_end_date, :award_value, :lowest_offer_value, :highest_offer_value, 
              :offers_count, :estimated_value, :estimated_low_value, :estimated_high_value, 
              :framework_duration_in_days, :framework_duration_in_months, :framework_duration_in_years, 
              :framework_estimated_value, :framework_estimated_low_value, :framework_estimated_high_value, 
              :keywords, :created_at, :updated_at, :award_published_on, :potential_retender_date, :tender_urls, 
              :award_urls, :spider_id, :delta, :file_reference_number, :creator_id, :naics_code_id, 
              :classification_code_id, :salesforce_id, :expected_revenue, :forecast_category, :last_modified_by, 
              :lead_source, :next_step, :private, :probability, :quantity, :stage, :salesforce_type, :industry, 
              :partner, :primary, :role, :competitor, :strengths, :weaknesses, :set_aside, :archiving_policy, 
              :archive_date, :original_set_aside, :awarded_at, :place_of_performance, :request_awards, 
              :retender_status, :status, :dispatch_date

  attribute(:country) { CountrySerializer.new(object.organization.try(:country)) if object.organization }
  attribute(:city) { object.try(:organization).try(:city_name) }
  attribute(:contact_email) { object.try(:organization).try(:email) }
  attribute(:contact_phone) { object.try(:organization).try(:phone) }
  attribute(:classification) { object.try(:classification).try(:description) }

  has_many :naicses, serializer: Core::NaicsSerializer
  
  attribute(:bidsense) do
    # byebug
    current_user ||= @instance_options[:current_user] || @instance_options[:scope]
    Bidsense.score(profile: current_user.profiles.first, tender: object, search_monitor: @instance_options[:search_monitor])
  end
end