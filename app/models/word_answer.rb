class WordAnswer < ActiveRecord::Base
  belongs_to :word

  validates :content, presence: true, length: {maximum: 50}
end
