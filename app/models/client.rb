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

  # Returns client with largest progress attribute
  def self.most_progress
    order('progress DESC').first
  end

  # Returns client with most completed appointments
  def self.most_dedicated
    order('completed_appointments DESC').first
  end

  # Sums up all weight changes documented via the client's weight histories and sets that sum equal to the
  # client's progress attribute
  def update_progress
    progress = 0
    self.weight_histories.each do |w|
      progress += w.weight_recording
    end
    self.update(progress: progress)
  end

  # Adds 1 to client's completed appointments
  def complete_appointment
    self.update(completed_appointments: self.completed_appointments += 1)
  end

  # Takes difference of old and new weights and creates a weight history object to document progress
  def document_progress(new_weight, old_weight)
    if self.goal == "Lose Weight"
      self.weight_histories.create(weight_recording: (old_weight - new_weight))
    elsif self.goal == "Gain Weight"
      self.weight_histories.create(weight_recording: (new_weight - old_weight))
    end
  end

  # Custom attribute setter for nested appointment form in client form
  def appointments_attributes=(appointments_attributes)
    # If submitted client is valid
    if self.valid?
      appointments_attributes.values.each do |appointment_attributes|
        # Clients have only 1 associated appointment object. Instead of creating new objects
        # we simply update the date attribute once an appointment is completed
        if self.appointments.last != nil
          self.appointments.last.update(appointment_attributes)
        else
          # Create new appointment object and make it belong to new client
          appointment = Appointment.create(appointment_attributes)
          self.appointments << appointment
        end
      end
    end
  end
end
