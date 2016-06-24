class Activity < ActiveRecord::Base
  belongs_to :user
  default_scope -> {order created_at: :desc}

  enum action: {follow: 1, unfollow: 2, start_lesson: 3, complete_lesson: 4}
end
