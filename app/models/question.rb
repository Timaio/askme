class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: "User", optional: true
  has_and_belongs_to_many :hashtags

  validates :body, presence: true, length: { maximum: 280 }

  after_commit :create_hashtags, on: %i[create update]

  def extract_hashtags
    body.scan(/#[\wа-яё]+/i).map{ |name| name.gsub("#", "").downcase }
  end

  def create_hashtags
    extract_hashtags.each do |text|
      hashtags.create(text: text) unless Hashtag.find_by(text: text).present?
    end
  end
end
