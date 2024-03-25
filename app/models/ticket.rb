class Ticket < ApplicationRecord
  include AASM

  STATUSES = [
    NEW = :new,
    PENDING = :pending,
    RESOLVED = :resolved,
  ].freeze

  has_many :comments, dependent: :destroy

  validates :name, :email, :subject, presence: true
  validates :email, format: URI::MailTo::EMAIL_REGEXP

  aasm :status do
    state NEW, initial: true
    state PENDING
    state RESOLVED

    event :start do
      transitions from: NEW, to: PENDING
    end

    event :resolve do
      transitions from: [NEW, PENDING], to: RESOLVED do
        guard { comments.any? }
      end
    end
  end
end
