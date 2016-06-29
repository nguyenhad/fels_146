class Lesson < ActiveRecord::Base
  has_many :lesson_words, dependent: :destroy
  belongs_to :category
  belongs_to :user

  before_save :assign_words

  validates :category, presence: true
  validate :check_words_category

  private
  def assign_words
    Word.in_category(self.category).random.limit(Settings.questions_in_lesson)
      .each do |word|
      self.lesson_words.build word_id: word.id
    end
  end

  def check_words_category
    unless self.category && self.category.words.count >= Settings.minimum_words
      self.errors.add :category,
        I18n.t("model.lesson.errors.category_not_satisfy")
    end
  end
end
