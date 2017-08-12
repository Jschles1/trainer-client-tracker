class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone, :age, :weight, :goal, :completed_appointments, :progress
  has_many :appointments
end
