class Marketplace::TenderCollaborator < ApplicationRecord
  belongs_to :collaboration, class_name: 'Marketplace::Collaboration'
  belongs_to :user
  belongs_to :invited_by_user, class_name: 'User'
  enum role: [:owner, :admin, :editor, :viewer]

  
  enum status: [:active, :pending, :ignore]

  scope :active, -> { where(status: :active) }
  scope :pending, -> { where(status: :pending) }
  scope :ignored, -> { where(status: :ignore) }

  validates :role, presence: true
  validates :user, uniqueness: { scope: [:collaboration_id] }

  after_create :send_email


  private
  def send_email
    CustomPostmarkMailer.template_email(
      self.user.email,
      Rails.configuration.mailer['templates']['collaboration_invite'],
      {
        user_name: current_user.profiles.first.fullname,
        tender_name: self.collaboration.tender.title,
        tender_id: self.collaboration.tender.id,
        tender_details_url: Rails.configuration.mailer['uri']['tender_details'],
        invite_link_url: '',
        product_url: Rails.configuration.mailer['product_url'],
        support_url: Rails.configuration.mailer['support'],
        company_name: Rails.configuration.mailer['company_name'],
        company_address: Rails.configuration.mailer['company_address']
      }
    ).deliver_later
  end

end
