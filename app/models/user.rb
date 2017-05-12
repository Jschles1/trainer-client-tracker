class User < ApplicationRecord
  has_many :appointments
  has_many :clients, through: :appointments

  has_secure_password

  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
end
