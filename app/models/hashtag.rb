class Hashtag < ApplicationRecord
  HASHTAG_REGEX = /#[\wа-яё]+/i
  
  has_and_belongs_to_many :questions

  scope :only_used, -> { joins(:hashtags_questions).distinct.order(created_at: :desc) }
end
