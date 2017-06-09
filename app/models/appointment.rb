class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :client

  validates_datetime :date, :on => :create, :on => :update, :on_or_after => :today
  validates :date, presence: true
  validates :date, uniqueness: true
end
