class WordAnswer < ActiveRecord::Base
  belongs_to :word

  scope :correct, -> {where is_correct: true}

  validates :content, presence: true, length: {maximum: 50}
end
