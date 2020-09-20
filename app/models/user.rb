class User < ApplicationRecord
  has_secure_password

  # attr_accessor :id,
  #   :email,
  #   :password

  validates :email, presence: true, uniqueness: true

  belongs_to :member
end
