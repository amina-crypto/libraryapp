json.extract! library_resource, :id, :title, :publish_year, :language, :publisher, :description, :type, :created_at, :updated_at
json.url library_resource_url(library_resource, format: :json)
