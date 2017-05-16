class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :client
  # validates :date, numericality: { greater_than: Time.now }
  validates_datetime :date, :on => :create, :on_or_after => :today
  validates :date, presence: true
  validates :date, uniqueness: true
end
