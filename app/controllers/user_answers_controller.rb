class UserAnswersController < ApplicationController
  def create
    @question = Question.find(params[:user_answer][:question_id])
    @choices = @question.choices
    @user_answer = build_user_answer
    if @user_answer.save
      redirect_after_successful_save
    else
      handle_save_failure
    end
  end

  private

  def build_user_answer
    current_user.user_answers.build(user_answer_params)
  end

  def redirect_after_successful_save
    if next_question_exists?
      redirect_to next_question_path
    else
      create_diagnosis_result_and_redirect
    end
  end

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

  def create_diagnosis_result_and_redirect
    @diagnosis = current_user.diagnosis_results.create
    redirect_to process_answers_user_diagnosis_result_path(current_user, @diagnosis)
  end

  def handle_save_failure
    flash.now[:danger] = '回答に失敗しました'
    render 'questions/show', status: :unprocessable_entity
  end
end
