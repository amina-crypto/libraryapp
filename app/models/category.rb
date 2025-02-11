class Category < ApplicationRecord
  has_many :categorizations
  has_many :library_resources, through: :categorizations

  validates :name, presence: true, uniqueness: true
end
