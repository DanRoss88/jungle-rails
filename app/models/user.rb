class User < ApplicationRecord
  has_secure_password

  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true

  before_validation :strip_whitespace_from_names
  before_validation :strip_whitespace_from_email

  def self.authenticate_with_credentials(email, password)
    user = User.find_by('LOWER(email) = ?', email.strip.downcase)
    return nil unless user&.authenticate(password)

    user
  end

  private

  def strip_whitespace_from_names
    self.first_name = first_name.strip if first_name.present?
    self.last_name = last_name.strip if last_name.present?
  end

  def strip_whitespace_from_email
    self.email = email.strip.downcase if email.present?
  end

  def password_required?
    new_record? || password.present?
  end
end