class AddVolumeAndIssueToLibraryResources < ActiveRecord::Migration[8.0]
  def change
    add_column :library_resources, :volume, :integer
    add_column :library_resources, :issue, :integer
  end
end
