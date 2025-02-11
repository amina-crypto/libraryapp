class Fine < ApplicationRecord
  belongs_to :loan

  enum status: { unpaid: 0, paid: 1 }

  before_save :calculate_fine

  private
  def calculate_fine
    if loan.returned_at && loan.returned_at > loan.due_date
      overdue_days = (loan.returned_at.to_date - loan.due_date.to_date).to_i
      self.amount = [ overdue_days * 50, 500 ].min
    else
      self.amount = 0
    end
  end
end
