json.extract! book, :id, :title, :publish_year, :language, :publisher, :description, :author, :created_at, :updated_at
json.url book_url(book, format: :json)
