class CreateLoans < ActiveRecord::Migration[8.0]
  def change
    create_table :loans do |t|
      t.references :user, null: false, foreign_key: true
      t.references :library_resource, null: false, foreign_key: true
      t.datetime :loan_date
      t.datetime :due_date
      t.datetime :returned_at
      t.decimal :fine

      t.timestamps
    end
  end
end
