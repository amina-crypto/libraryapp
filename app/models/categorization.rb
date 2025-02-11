class Categorization < ApplicationRecord
  belongs_to :category
  belongs_to :library_resource
end
