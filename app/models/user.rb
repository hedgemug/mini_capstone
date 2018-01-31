class User < ApplicationRecord
  has_many :orders
  has_secure_password
  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true
end
