class User < ApplicationRecord
  has_secure_password

  before_save :downcase_nickname

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not in the correct format" }
  validates :nickname, presence: true, uniqueness: true, 
    length: { maximum: 40 },
    format: { with: /\A[a-z0-9_]+\Z/i, message: "can contain only latin letters, digits and underscores" }

  def downcase_nickname
    nickname.downcase!
  end
end
