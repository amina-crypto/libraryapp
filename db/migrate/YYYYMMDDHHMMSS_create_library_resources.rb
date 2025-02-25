class CreateLibraryResources < ActiveRecord::Migration[7.0]
  def change
    create_table :library_resources do |t|
      t.string :title, null: false
      t.integer :publish_year, null: false
      t.string :language, null: false
      t.string :publisher
      t.text :description
      t.string :type  # For STI (Book/Journal)
      t.string :author  # For books
      t.integer :volume # For journals
      t.integer :issue  # For journals
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
