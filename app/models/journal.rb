class Journal < LibraryResource
  validates :volume, :issue, presence: true

  def available?
    !loans.active.exists? && !reservations.active.exists?
  end
end
