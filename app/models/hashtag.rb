class Hashtag < ApplicationRecord
  HASHTAG_REGEX = /#[\wа-яё]+/i
  
  has_and_belongs_to_many :questions
end
