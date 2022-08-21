class User < ApplicationRecord
  has_secure_password

  before_validation :downcase_fields

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :nickname, presence: true, uniqueness: true, 
    length: { maximum: 40 },
    format: { with: /\A[a-z0-9_]+\z/ }
  validates :header_color, allow_nil: true, format: { with: /\A#[a-f0-9]{6}\z/ }

  private

  def downcase_fields
    nickname.downcase!
    email.downcase!
    header_color&.downcase!
  end
end
