class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :library_resource, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :expires_at
      t.boolean :is_active, default: true

      t.timestamps
    end

    add_index :reservations, [ :library_resource_id, :is_active ]
  end
end
