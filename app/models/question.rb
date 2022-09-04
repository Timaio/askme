class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: "User", optional: true
  has_and_belongs_to_many :hashtags

  validates :body, presence: true, length: { maximum: 280 }

  after_commit :create_hashtags, on: %i[create update]

  def extract_hashtags(text)
    text.scan(/#[\wа-яё]+/i).map{ |name| name.gsub("#", "").downcase }
  end

  def create_hashtags
    all_hashtags = extract_hashtags(body)
    all_hashtags += extract_hashtags(answer) if answer.present?
    
    all_hashtags.uniq.each do |text|
      self.hashtags << (Hashtag.find_by(text: text) || Hashtag.create(text: text))
    end
  end
end
