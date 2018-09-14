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
  has_many :tenders, through: :tender_committees
  has_many :comments, class_name: 'CompeteComment'

  enum role: [:admin, :user]

  after_initialize :set_default_role, :if => :new_record?

  # scope :paginate, ->(page, page_size) { page(page).per(page_size) }

  def set_default_role
    self.role ||= :user
  end

end
