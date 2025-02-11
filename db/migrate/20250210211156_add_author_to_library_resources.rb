class AddAuthorToLibraryResources < ActiveRecord::Migration[8.0]
  def change
    add_column :library_resources, :author, :string
  end
end
