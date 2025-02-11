json.extract! journal, :id, :title, :publish_year, :language, :publisher, :description, :volume, :issue, :created_at, :updated_at
json.url journal_url(journal, format: :json)
