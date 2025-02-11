class CreateFines < ActiveRecord::Migration[8.0]
  def change
    create_table :fines do |t|
      t.references :loan, null: false, foreign_key: true
      t.decimal :amount
      t.integer :status

      t.timestamps
    end
  end
end
