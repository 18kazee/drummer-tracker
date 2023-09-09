class DiagnosisResultsController < ApplicationController
  def show
    @drummers = RecommendedDrummer.where(user_id: params[:user_id], diagnosis_result_id: params[:id])
    @drummers_name = []
  end

  def process_answers
    filter_drummers
    select_and_manage_drummer
    redirect_to action: :show
  end

  private

  def filter_drummers
    # 最新のジャンルに関するユーザー回答を取得
    @latest_genre_user_answer = current_user.user_answers.where(question_id: 1).last
    return if @latest_genre_user_answer.blank?

    # ユーザーが選択したジャンルを抽出
    selected_genres = Choice.select_user_genres(@latest_genre_user_answer)
    all_drummers = selected_genres.flat_map(&:drummers)

    # 最新の洋楽か邦楽かに関するユーザー回答を取得
    @latest_music_origin_answer = current_user.user_answers.where(question_id: 2).last
    return if @latest_music_origin_answer.blank?

    # ユーザーが選択した洋楽か邦楽かを抽出
    choice = Choice.find(@latest_music_origin_answer.choice_id)

    # ジャンルの回答で得たドラマーの中から、選択した洋楽か邦楽かでドラマーを絞り込む
    @filtered_drummers = Choice.filter_drummers_by_country(all_drummers, choice.content)
  end

  def select_and_manage_drummer
    # 新しいランダムなドラマーを選択し、セッションに記録する
    random_drummers = @filtered_drummers.sample(3)
    random_drummers.pluck(:id)
    Choice.select_and_save_drummers(random_drummers, current_user)
  end
end
