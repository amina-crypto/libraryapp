class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :library_resource
  has_one :fine

  scope :active, -> { where(returned_at: nil) }
  scope :overdue, -> { active.where("due_date < ?", Date.current) }

  before_create :set_due_date

  private
  def set_due_date
    self.due_date = 2.weeks.from_now
  end
end
