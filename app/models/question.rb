class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: "User", optional: true
  has_and_belongs_to_many :hashtags

  validates :body, presence: true, length: { maximum: 280 }

  after_commit :create_hashtags, on: %i[create update]

  private

  def extract_hashtags(text)
    text.scan(Hashtag::HASHTAG_REGEX).map{ |name| name.gsub("#", "").downcase }
  end

  def create_hashtags
    self.hashtags = extract_hashtags("#{body} #{answer}").uniq.map { 
      |text| Hashtag.find_or_create_by(text: text) }
  end
end
