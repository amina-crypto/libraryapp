class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :library_resource
  has_one :fine

  before_create :set_due_date

  private
  def set_due_date
    self.due_date = Time.current + 2.weeks
  end
end
