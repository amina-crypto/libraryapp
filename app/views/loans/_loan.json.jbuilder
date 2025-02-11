json.extract! loan, :id, :user_id, :library_resource_id, :loan_date, :due_date, :returned_at, :created_at, :updated_at
json.url loan_url(loan, format: :json)
