class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :contact_address
      t.string :email
      t.string :password_digest
      t.integer :role

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
