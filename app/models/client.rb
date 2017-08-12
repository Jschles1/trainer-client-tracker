class Client < ApplicationRecord
  include ActiveModel::Validations

  has_many :appointments
  has_many :weight_histories
  has_many :users, through: :appointments
  has_many :notes
  
  validates :name, :email, :phone, :age, :weight, :goal, presence: true
  validates :email, uniqueness: true, email: true
  validates :age, numericality: { greater_than: 0, less_than: 100 }
  validates :weight, numericality: { greater_than: 0 }
  validates :phone, phone: true

  def self.most_progress
    order('progress DESC').first
  end

  def self.most_dedicated
    order('completed_appointments DESC').first
  end

  def update_progress
    progress = 0
    self.weight_histories.each do |w|
      progress += w.weight_recording
    end
    self.update(progress: progress)
  end

  def complete_appointment
    self.update(completed_appointments: self.completed_appointments += 1)
  end

  def document_progress(new_weight, old_weight)
    if self.goal == "Lose Weight"
      self.weight_histories.create(weight_recording: (old_weight - new_weight))
    elsif self.goal == "Gain Weight"
      self.weight_histories.create(weight_recording: (new_weight - old_weight))
    end
  end

  def appointments_attributes=(appointments_attributes)
    if self.valid?
      appointments_attributes.values.each do |appointment_attributes|
        if self.appointments.last != nil
          self.appointments.last.update(appointment_attributes)
        else
          appointment = Appointment.create(appointment_attributes)
          self.appointments << appointment
        end
      end
    end
  end
end
