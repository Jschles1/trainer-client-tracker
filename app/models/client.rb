class Client < ApplicationRecord
  has_many :appointments
  has_many :users, through: :appointments
  validates :name, :email, :phone, :age, :weight, :goal, presence: true
  validates :email, uniqueness: true
  validates :age, numericality: { greater_than: 0, less_than: 100 }
  validates :weight, numericality: { greater_than: 0 }
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_format_of :phone, :with => /\d{3}-\d{3}-\d{4}/, :on => :create
end
