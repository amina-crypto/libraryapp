class CreateLoans < ActiveRecord::Migration[7.0]
  def change
    create_table :loans do |t|
      t.references :library_resource, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :due_date
      t.date :return_date
      t.boolean :is_returned, default: false

      t.timestamps
    end

    add_index :loans, [ :library_resource_id, :return_date ]
  end
end
