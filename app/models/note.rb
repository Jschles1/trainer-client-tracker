class Details < ActiveRecord::Base
	belongs_to :client

  validates :text, presence: true
end
