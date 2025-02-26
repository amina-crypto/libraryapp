class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :library_resource

  enum status: { pending: 0, approved: 1, rejected: 2 }

  scope :active, -> { where("created_at >= ?", 2.hours.ago) }

  before_create :set_expiration

  private
  def set_expiration
    self.expires_at = 2.hours.from_now
  end
end
