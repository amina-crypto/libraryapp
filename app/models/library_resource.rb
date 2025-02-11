class LibraryResource < ApplicationRecord
  has_many :reservations
  has_many :loans
  has_many :categorizations
  has_many :categories, through: :categorizations

  validates :title, :publish_year, :language, presence: true
end
