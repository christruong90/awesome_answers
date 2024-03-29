class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :path, :created_at

  has_many :answers
  
  include Rails.application.routes.url_helpers

  def path
    question_path(object)
  end

  def created_at
    object.created_at.strftime('%Y-%B-%d')
  end

end
