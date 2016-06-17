class Answer < ActiveRecord::Base
  belongs_to :question
  validates :body, presence: true, uniqueness: {score: :question_id}
end
