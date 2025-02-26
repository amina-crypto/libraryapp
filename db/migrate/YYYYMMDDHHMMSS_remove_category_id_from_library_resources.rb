class RemoveCategoryIdFromLibraryResources < ActiveRecord::Migration[7.0]
  def change
    remove_reference :library_resources, :category, foreign_key: true
  end
end
