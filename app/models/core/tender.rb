# original model source: apps/domain-core/domain/tenders/domain/tender.rb
class Core::Tender < ApplicationRecord
  include Pageable

  self.table_name = "core_tenders"

  belongs_to :currency, optional: true
  belongs_to :organization, optional: true
  belongs_to :procedure, optional: true
  belongs_to :classification, class_name: 'Core::ClassificationCode', foreign_key: :classification_code_id, optional: true
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
  has_and_belongs_to_many :attachments
  has_many :team_members, through: :tender_committees, source: :user, class_name: 'User'
  has_many :task_sections, class_name: 'Marketplace::TenderTaskSection'
  has_many :tasks, class_name: 'Marketplace::TenderTask'
  has_many :criteria_sections, class_name: 'Marketplace::TenderCriteriaSection'
  has_many :criteries, class_name: 'Marketplace::TenderCriterium'
  has_many :award_criteria_sections, class_name: 'Marketplace::TenderAwardCriteriaSection'
  has_many :award_criteries, class_name: 'Marketplace::TenderAwardCriterium', through: :award_criteria_sections
  has_many :bid_no_bid_questions, class_name: 'Marketplace::BidNoBidQuestion'
  has_many :bid_no_bid_answers, through: :bid_no_bid_questions, class_name: 'Marketplace::BidNoBidAnswer'
  has_many :bid_no_bid_compete_answers, class_name: 'Marketplace::Compete::BidNoBidAnswer'
  has_many :bidsense_results
  has_many :collaboration_interests
  belongs_to :industry, optional: true
  belongs_to :creator, class_name: 'User', optional: true
  has_and_belongs_to_many :buyers, class_name: 'User'

  enum status: [:created, :open, :archived]

  scope :active, -> { active_on(DateTime.now) }
  scope :active_on, ->(date) { where(Core::Tender.arel_table[:submission_datetime].gt(date)) }
  scope :inactive, -> { inactive_on(DateTime.now) }
  scope :inactive_on, ->(date) { where(Core::Tender.arel_table[:submission_datetime].lt(date)) }

  after_save :recalculate_bidsense

  # scope :paginate, ->(page, page_size) { page(page).per(page_size) }

  scope :with_relations, -> do
    relations = [:currency, :procedure, :classification, :additional_information, :documents, organization: [ :country ] ]
    includes(relations).references(*relations)
  end

  def matched_competitor_bidsense
    self.bidsense_results.where('average_score > ?', 0.6)
  end

  def create_qa
    if self.bid_no_bid_questions.count == 0
      ActiveRecord::Base.transaction do
        (1..8).each do |question_num|
          question_name = "Question #{question_num}"
          question = self.bid_no_bid_questions.create!({question_text: question_name, position: question_num})
          (1..5).each do |ans_num|
            answer_name = "Answer #{ans_num}"
            question.bid_no_bid_answers.create!({ answer_text: answer_name, position: ans_num } )
          end 
        end
      end
    end
  end

  def get_bnb_data
    data = []
    Marketplace::BidNoBidQuestion.all.each do |question|
      _tmp = {}
      answers = question.bid_no_bid_answers.map do |e|
        {
          id: e.id,
          answer_text: e.answer_text,
          order: e.order
        }
      end
      answered = self.bid_no_bid_compete_answers.where(bid_no_bid_question: question).map do |e| 
        { 
          id: e.id, 
          user_id: e.user.id, 
          answer_id: e.bid_no_bid_answer.id
        } 
      end
      _tmp[:question] = {
        id: question.id,
        question_text: question.question_text,
        available_answers: answers,
        answered: answered
      }
      data << _tmp
    end
    data
  end

  def process_bnb_data(params, current_user)
    # byebug

  end

  def self.search(tender_title: nil, tender_keywords: nil, tender_value_from: nil, tender_value_to: nil, 
                  tender_countries: nil)

    matches = []
    matches <<  {
                  range:
                  {
                    high_value:
                    {
                     lte: tender_value_to
                    }
                  }
                } if tender_value_to

    matches << {
                  range:
                  {
                    low_value:
                    {
                      gte: tender_value_from
                    }
                  }
                } if tender_value_from

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

  def owner?(current_user)
    creator == current_user
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

  private
  def recalculate_bidsense
    Bidsense::RecalculateScoreJob.perform_later tender: self
  end
end
