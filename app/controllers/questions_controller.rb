class QuestionsController < ApplicationController
  skip_before_action :redirect_if_logged_in

  def show
    @question = Question.find(params[:id])
    @choices = Choice.where(question_id: params[:id])
    @user_answer = UserAnswer.new
    @next_question = @question.next_question
    @previous_question = @question.previous_question
  end
end
