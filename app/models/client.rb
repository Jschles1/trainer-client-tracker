class Client < ApplicationRecord
  include ActiveModel::Validations

  has_many :appointments
  has_many :weight_histories
  has_many :users, through: :appointments

  validates :name, :email, :phone, :age, :weight, :goal, presence: true
  validates :email, uniqueness: true, email: true
  validates :age, numericality: { greater_than: 0, less_than: 100 }
  validates :weight, numericality: { greater_than: 0 }
  validates :phone, phone: true

  def self.most_progress

  end

  def self.most_dedicated

  end

  def complete_appointment
    self.update(completed_appointments: self.completed_appointments += 1)
  end

  def document_progress(new_weight)

  end

  def appointments_attributes=(appointments_attributes)
    if self.valid?
      appointments_attributes.values.each do |appointment_attributes|
        if self.appointments.last != nil
          self.appointments.last.update(appointment_attributes)
        else
          appointment = Appointment.create(appointment_attributes)
          self.appointments << appointment
          appointment.update(appointment_attributes)
        end
      end
    end
  end
end
