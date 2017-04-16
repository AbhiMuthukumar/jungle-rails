class User < ActiveRecord::Base
  has_secure_password

  has_many :review
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
