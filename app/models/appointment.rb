class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :client

  validates_datetime :date, :on => :create, :on_or_after => :today
  validates :date, presence: true
  validates :date, uniqueness: true

  def date_parse
    date.strftime("%b %e, %l:%M %p")
  end

  def client_attributes=(client_attributes)
    if client_attributes[:name] != ""
      self.client = Client.find_or_create_by(client_attributes)
      self.client.update(client_attributes)
    end
  end
end
