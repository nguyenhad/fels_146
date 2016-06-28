class LessonWord < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word

  INNER_JOIN_QUERRY = "INNER JOIN word_answers ON lesson_words.word_id =
    word_answers.word_id AND lesson_words.word_answer_id = word_answers.id"
  scope :in_lesson, -> (lesson) {where lesson_id: lesson.id}
  scope :correct, -> {joins(INNER_JOIN_QUERRY).merge(WordAnswer.correct)}
end
