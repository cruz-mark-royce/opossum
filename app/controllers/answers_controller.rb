class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    blow up 
    @answer.save
  end

  def answer_params
    params.require(:answer).permit(:question_id, :submission_id, :value)
  end

end
