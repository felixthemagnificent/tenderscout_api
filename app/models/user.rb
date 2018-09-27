class User < ApplicationRecord
  include Pageable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :doorkeeper

  has_many :profiles
  has_many :search_monitors
  has_many :favourite_monitors
  has_many :tenders, through: :tender_collaborators
  has_many :comments, class_name: 'CompeteComment'
  has_many :collaboration_interests

  enum role: [:admin, :user]

  after_initialize :set_default_role, :if => :new_record?

  # scope :paginate, ->(page, page_size) { page(page).per(page_size) }

  def set_default_role
    self.role ||= :user
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
