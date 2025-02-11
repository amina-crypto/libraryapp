class CreateReservations < ActiveRecord::Migration[8.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :library_resource, null: false, foreign_key: true
      t.datetime :reserved_at
      t.datetime :expires_at
      t.integer :status

      t.timestamps
    end
  end
end
