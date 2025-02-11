class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :library_resource

  enum status: { pending: 0, approved: 1, rejected: 2 }

  before_create :set_expiration

  private
  def set_expiration
    self.expires_at = Time.current + 2.hours
  end
end
