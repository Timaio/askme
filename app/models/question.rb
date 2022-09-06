class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: "User", optional: true
  has_and_belongs_to_many :hashtags

  validates :body, presence: true, length: { maximum: 280 }

  before_save :update_hashtags
  after_commit :delete_unused_hashtags, on: %i[update destroy]

  private

  def extract_hashtags(text)
    text.scan(Hashtag::HASHTAG_REGEX).map{ |name| name.gsub("#", "").downcase }
  end

  def update_hashtags
    self.hashtags = extract_hashtags("#{body} #{answer}").uniq.map { 
      |text| Hashtag.find_or_create_by(text: text) }
  end

  def delete_unused_hashtags
    Hashtag.left_outer_joins(:hashtags_questions)
      .where(hashtags_questions: {hashtag_id: nil}).delete_all
  end
end
