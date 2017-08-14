class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :client_id, :date
  belongs_to :client
end
