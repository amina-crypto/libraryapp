json.extract! reservation, :id, :user_id, :library_resource_id, :reserved_at, :expires_at, :status, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
