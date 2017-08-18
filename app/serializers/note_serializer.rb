class NoteSerializer < ActiveModel::Serializer
  attributes :id, :text
  belongs_to :client
end
