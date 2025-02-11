class Book < LibraryResource
  validates :author, presence: true
end
