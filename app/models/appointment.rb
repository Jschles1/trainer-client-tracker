class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :client

  validates :date, numericality { greater_than: Time.now }
  validates :date, presence: true
  validates :date, uniqueness: true
end
