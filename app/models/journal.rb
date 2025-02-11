class Journal < LibraryResource
  validates :volume, :issue, presence: true
end
