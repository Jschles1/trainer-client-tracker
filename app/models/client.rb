class Client < ApplicationRecord
  include ActiveModel::Validations

  has_many :appointments
  has_many :users, through: :appointments

  validates :name, :email, :phone, :age, :weight, :goal, presence: true
  validates :email, uniqueness: true, email: true
  validates :age, numericality: { greater_than: 0, less_than: 100 }
  validates :weight, numericality: { greater_than: 0 }
  validates :phone, phone: true

  def document_progress(progress)
    if self.goal == "Gain Weight"
      self.weight_change = progress
      self.weight += self.weight_change
    elsif self.goal == "Lose Weight"
      self.weight_change = progress
      self.weight -= self.weight_change
    end
  end

  def appointments_attributes=(appointments_attributes)
    if self.valid?
      appointments_attributes.values.each do |appointment_attributes|
        appointment = Appointment.create(appointment_attributes)
        self.appointments << appointment
        appointment.update(appointment_attributes)
      end
    end
  end
end
