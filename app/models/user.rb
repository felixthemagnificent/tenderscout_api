class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :doorkeeper

  has_many :profiles
  has_many :search_monitors
  has_many :favourite_monitors
  has_many :tenders, through: :tender_committees

  enum role: [:admin, :user]

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

end
