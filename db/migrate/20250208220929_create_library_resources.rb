class CreateLibraryResources < ActiveRecord::Migration[8.0]
  def change
    create_table :library_resources do |t|
      t.string :title
      t.integer :publish_year
      t.string :language
      t.string :publisher
      t.text :description
      t.string :type # STI Field: "Book" or "Journal"

      # Book-specific fields
      t.string :author

      # Journal-specific fields
      t.integer :volume
      t.integer :issue_number

      t.timestamps
    end
  end
end
