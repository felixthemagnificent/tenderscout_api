class User < ApplicationRecord
  include Pageable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :doorkeeper

  has_many :profiles
  has_many :search_monitors
  has_many :favourite_monitors
  has_many :tender_collaborators, class_name: 'Marketplace::TenderCollaborator'
  has_many :collaborations, through: :tender_collaborators
  has_many :tenders, through: :collaborations, source: :tender, class_name: 'Core::Tender'
  has_many :comments, class_name: 'CompeteComment'
  has_many :collaboration_interests
  has_many :tender_qualification_criteria_answers, class_name: 'Marketplace::TenderQualificationCriteriaAnswer'
  has_many :tender_award_criteria_answers, class_name: 'Marketplace::TenderAwardCriteriaAnswer'
  has_many :assignments, :class_name => 'Marketplace::Assignment'
  enum role: [:admin, :standart, :basic, :free]

  after_initialize :set_default_role, :if => :new_record?

  # scope :paginate, ->(page, page_size) { page(page).per(page_size) }

  def collaboration_tenders_statistic
    percent_array_result = []
    result = {}
    tenders.each do |tender|
     qualification_criteria_count = tender.qualification_criterias_count
     criteria_count = tender.award_criteries_count
     all_tender_qualification_criteria_answer_count = tender_qualification_criteria_answer_completed_count(tender)
     all_tender_award_criteria_answer_count = tender_award_criteria_answer_completed_count(tender)
     tender_complete_percent = calculate_tender_complete_percent(qualification_criteria_count,criteria_count,
                                                               all_tender_qualification_criteria_answer_count,
                                                               all_tender_award_criteria_answer_count)
      percent_array_result<<tender_complete_percent
     result = user_tender_statuses(percent_array_result)
    end
    result
  end

  def paid?
    self.standart? || self.admin? || self.basic?
  end

  def has_collaboration_on_tender?(tender)
    self.tender_collaborators.map(&:collaboration).map(&:tender).include?(tender)
  end
  
  def tender_qualification_criteria_answer_completed_count(tender)
    self.tender_qualification_criteria_answers.where(tender_id: tender.id).where(pass_fail: true).where.not(score: nil).count
  end

  def tender_award_criteria_answer_completed_count(tender)
    self.tender_award_criteria_answers.where(tender_id: tender.id).where(pass_fail: true).where.not(score: nil).count
  end

  def calculate_tender_complete_percent(qualification_criteria_count,criteria_count,
                                       all_tender_qualification_criteria_answer_count,
                                       all_tender_award_criteria_answer_count)
    tender_complete_percent = 0
    needed_requirement = qualification_criteria_count + criteria_count
    done_requirement = all_tender_qualification_criteria_answer_count + all_tender_award_criteria_answer_count
    if needed_requirement == 0
      tender_complete_percent = 0
    else
      tender_complete_percent = (done_requirement.to_f/needed_requirement.to_f * 100).round(0)
    end
    tender_complete_percent
  end

  def user_tender_statuses(percent_array_result)
    count_all = percent_array_result.count
    more_61  = 0
    more_31 = 0
    less_30 = 0
    done = 0
    status_result = {}
    percent_array_result.each do |tender|
      if tender == 100
        done +=1
      elsif tender > 61
        more_61 +=1
      elsif (31..60).include?(tender)
        more_31 +=1
      elsif  (0..30).include?(tender)
        less_30 +=1
      end
    end
     status_result = { total: count_all, complete: done,
                        complete_61: more_61, complete_31: more_31,
                        complete_less_31: less_30}
  end


  def set_default_role
    self.role ||= :free
  end

  def self.search(search_field)
    result = nil
    if search_field
      matches = []
      matches << { 
        match: { 
          fullname:{
            query: search_field,
            analyzer: :fullname_search,
            operator: :and,
            # prefix: 1
          } 
        }
      }
      matches << { 
        match: { 
          email: {
            query: search_field,
            analyzer: :fullname,
            operator: :and,
            # prefix: 1
          } 
        }
      }

      result = UsersIndex.query(
        bool: 
        { 
          should: matches 
        }
      )
    end
    result
  end
end
