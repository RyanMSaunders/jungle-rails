
class User < ApplicationRecord
  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.authenticate_with_credentials(email, password)
    stripped_email = email.strip.downcase
    user = find_by('lower(email) = ?', stripped_email)
    user && user.authenticate(password) ? user : nil
  end
end
