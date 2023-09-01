class UserAnswersController < ApplicationController
  def create
    @question = Question.find(params[:user_answer][:question_id])
    @choices = @question.choices
    @user_answer = current_user.user_answers.build(user_answer_params)
    if @user_answer.save
      if next_question_exists?
        redirect_to next_question_path
      else
        redirect_to recommended_drummers_path
      end
    else
      flash.now[:danger] = '回答に失敗しました'
      render 'questions/show', status: :unprocessable_entity
    end
  end

  private

  def user_answer_params
    params.require(:user_answer).permit(:question_id, :choice_id)
  end

  def next_question_exists?
    Question.exists?(id: next_question_id)
  end

  def next_question_id
    @user_answer.question_id + 1
  end

  def next_question_path
    question_path(next_question_id)
  end
end
