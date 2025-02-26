class LibraryResource < ApplicationRecord
  has_many :reservations
  has_many :loans
  has_many :categorizations
  has_many :categories, through: :categorizations

  validates :title, :publish_year, :language, presence: true
    # STI setup
    self.inheritance_column = :type # determines whether a resource is of type book or journal
    scope :available, -> { where.not(id: Loan.active.select(:library_resource_id)) }

  # Common availability logic for both Books and Journals
  def available?
    !has_active_loan? && !has_active_reservation?
  end

  def current_loan
    loans.where(returned_at: nil).first
  end

  def current_reservation
    reservations.where("expires_at > ?", Time.current).first
  end

  def category_names
    categories.pluck(:name)
  end

  private

  def has_active_loan?
    loans.where(returned_at: nil).exists?
  end

  def has_active_reservation?
    reservations.where("expires_at > ?", Time.current).exists?
  end
end
