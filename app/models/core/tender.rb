# original model source: apps/domain-core/domain/tenders/domain/tender.rb
class Core::Tender < ApplicationRecord
  self.table_name = "core_tenders"

  belongs_to :currency
  belongs_to :organization
  belongs_to :procedure
  belongs_to :classification, class_name: 'Core::ClassificationCode', foreign_key: :classification_code_id
  has_one :country, through: :organization
  has_many :documents
  has_many :additional_information
  has_many :awards
  has_many :tender_contacts
  has_many :contacts, through: :tender_contacts
  # has_and_belongs_to_many :cpvs, join_table: 'core_tenders_cpvs', foreign_key: :tender_id, association_foreign_key: :cpv_id
  has_many :tender_cpvs
  has_many :cpvs, through: :tender_cpvs
  has_many :tender_naicses, class_name: 'TenderNaics'
  has_many :naicses, through: :tender_naicses, source: 'naics'
  has_many :tender_ngips
  has_many :ngips, through: :tender_ngips
  has_many :tender_unspsces, class_name: 'TenderUnspsc'
  has_many :unspsces, through: :tender_unspsces, source: 'unspsc'
  has_many :tender_gsins
  has_many :gsins, through: :tender_gsins
  has_many :tender_categories
  has_many :categories, through: :tender_categories
  has_many :tender_nhs_e_classes
  has_many :nhs_e_classes, through: :tender_nhs_e_classes
  has_many :tender_pro_classes
  has_many :pro_classes, through: :tender_pro_classes
  has_many :tender_committees, class_name: 'Marketplace::TenderCommittee'
  has_many :committees, through: :tender_committees, source: :user, class_name: 'Marketplace::TenderCommittee'
  belongs_to :industry

  scope :active, -> { active_on(DateTime.now) }
  scope :active_on, ->(date) { where(Core::Tender.arel_table[:submission_datetime].gt(date)) }
  scope :inactive, -> { inactive_on(DateTime.now) }
  scope :inactive_on, ->(date) { where(Core::Tender.arel_table[:submission_datetime].lt(date)) }
  
  scope :paginate, ->(page, page_size) { page(page).per(page_size) }

  scope :with_relations, -> do
    relations = [:currency, :procedure, :classification, :additional_information, :documents, organization: [ :country ] ]
    includes(relations).references(*relations)
  end

  def self.search(tender_title: nil, tender_keywords: nil, tender_value_from: nil, tender_value_to: nil, 
                  tender_countries: nil)

    matches = []
    # matches <<  {
    #               range:
    #               {
    #                 value_max:
    #                 {
    #                  lte: valueTo
    #                 }
    #               }
    #             } if valueTo

    # matches << {
    #               range:
    #               {
    #                 value_max:
    #                 {
    #                   gte: valueFrom
    #                 }
    #               }
    #             } if valueFrom

    matches << {
                  match:
                  {
                    title: tender_title
                  }
                } unless tender_title.blank?

    if tender_keywords 
      match_keywords = []
      tender_keywords.each do |e| 
        match_keywords << {
          match:
          {
            description: e
          }
        }
      end
      matches << {
        bool: { 
            should: match_keywords
          }
      }
    end
    if tender_countries 
      match_countries = []
      tender_countries.each do |e| 
        match_countries << {
          match:
          {
            country_id: e
          }
        }
      end
      matches << {
        bool: { 
            should: match_countries
          }
      }
    end
    TendersIndex.query(matches).order(created_at: { order: :desc })
  end

  ####################################################################################################
  # accessors for fields only accessible when the tender is loaded with_relations
  def additional_information_list
    self.additional_information.map{ |ai| { title: ai.title, url: ai.url } } rescue []
  end

  def documents_list
    self.documents.map { |d| { title: d.title, url: d.url } } rescue []
  end

  def procedure_name
    self.procedure.name rescue nil
  end

  def currency_name
      self.currency.name rescue nil
  end

  def currency_code
      self.currency.code rescue nil
  end

  def organization_name
     self.organization.name rescue nil
  end

  def organization_phone
      self.organization.phone rescue nil
  end

  def country_name
      self.organization.country.name rescue nil
  end

  def world_region
      self.organization.country.world_region rescue nil
  end
  
  def world_subregion
      self.organization.country.world_subregion rescue nil
  end

  def classification_code
      self.classification.code rescue nil
  end

  def classification_description
      self.classification.description rescue nil
  end

  def format_fields
    {
      origin_id:              id,
      title:                  title,
      description:            description,
      published_on:           published_on,
      submission_datetime:    submission_datetime,
      procedure_id:           procedure_id,
      currency_id:            currency_id,
      organization_id:        organization_id,
      main_activity:          main_activity,
      contract_category:      contract_category,
      location:               location,
      nuts_codes:             nuts_codes,
      estimated_value:        estimated_value.to_f,
      created_at:             created_at,
      updated_at:             updated_at,
      award_published_on:     award_published_on,
      awarded_at:             awarded_at,
      awarded_on:             awarded_on,
      cancelled_on:           cancelled_on,
      tender_urls:            tender_urls.map{ |url| { url: url } },
      award_urls:             award_urls,
      classification_code_id: classification_code_id,
      set_aside:              set_aside,
      archiving_policy:       archiving_policy,
      archive_date:           archive_date,
      place_of_performance:   place_of_performance,
      duration:               [[contract_duration_in_days, 'days'],
                               [contract_duration_in_months, 'months'],
                               [contract_duration_in_years, 'years']].find{ |d| !d[0].nil? }
    }
  end
end
