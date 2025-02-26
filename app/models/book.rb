class Book < LibraryResource
  validates :author, presence: true
  belongs_to :category

  def available?
    !loans.active.exists? && !reservations.active.exists?
  end
end
