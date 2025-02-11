class CreateLibraryResources < ActiveRecord::Migration[8.0]
  def change
    create_table :library_resources do |t|
      t.string :title
      t.integer :publish_year
      t.string :language
      t.string :publisher
      t.text :description
      t.string :type

      t.timestamps
    end
  end
end
