class Word < ActiveRecord::Base
  has_many :word_answers, dependent: :destroy
  has_many :lesson_words, dependent: :destroy
  belongs_to :category

  validates :name, presence: true, length: {maximum: 50}

  validate :check_answers

  accepts_nested_attributes_for :word_answers, allow_destroy: true,
    reject_if: proc {|attributes| attributes[:content].blank?}

  def check_answers
    if self.word_answers.empty?
      self.errors.add :word, I18n.t("models.word.errors.required_answer")
    else
      count_correct_answers = 0
      self.word_answers.each do |answer|
        count_correct_answers += 1 if answer.is_correct?
      end
      if count_correct_answers != 1
        self.errors.add :word, I18n.t("models.word.errors.correct_answer")
      end
    end
  end
end
