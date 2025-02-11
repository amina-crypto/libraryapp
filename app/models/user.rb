class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_secure_password
  has_many :reservations
  has_many :loans

  validates :email, presence: true, uniqueness: true

 # Set up STI (Single Table Inheritance)
 self.inheritance_column = :role
end
