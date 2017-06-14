class User < ApplicationRecord
  include ActiveModel::Validations

  has_many :appointments
  has_many :clients, through: :appointments

  validates :name, :email, presence: true
  validates :email, uniqueness: true, email: true
  validates :password, length: { minimum: 8 }
  has_secure_password

  def self.from_omniauth(auth)
    self.where(:uid => auth["uid"]).first_or_create do |user|
      user.name = auth["info"]["name"]
      user.email = "#{auth["uid"]}@#{auth["provider"]}.com"
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.password = SecureRandom.hex(8)
      user.password_confirmation = user.password
      user.save!
    end
  end
end
