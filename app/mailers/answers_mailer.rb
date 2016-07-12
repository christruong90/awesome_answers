class AnswersMailer < ApplicationMailer

  def notify_question_owner(answer)
      @answer = answer
      @question = answer.question
      @owner = @question.user
      mail(to: @owner.email, subject: "you got an answer!") if @owner

  end

end
