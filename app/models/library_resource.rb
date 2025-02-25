class LibraryResource < ApplicationRecord
  has_many :reservations
  has_many :loans
  has_many :categorizations
  has_many :categories, through: :categorizations

  validates :title, :publish_year, :language, presence: true
    # STI setup
    self.inheritance_column = :type # determines whether a resource is of type book or journal
    scope :available, -> { where.not(id: Loan.active.select(:library_resource_id)) }
end
