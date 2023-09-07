class RecommendedDrummersController < ApplicationController
  def index
    filter_drummers
    select_and_manage_drummer
    @drummers_name = []
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
    Rails.logger.debug "filterd drummers count: #{@filtered_drummers.count}"
  end

  def select_and_manage_drummer
    # セッションから選択したドラマーのIDを取得する
    selected_drummer_ids = session[:selected_drummer_ids] || []

    # 前回のジャンル回答と異なる場合に新しいドラマーを選択し、セッションに保存する
    if session[:latest_genre_user_answer] != @latest_genre_user_answer.id

      # 新しいランダムなドラマーを選択し、セッションに記録する
      random_drummers = @filtered_drummers.sample(3)
      selected_drummer_ids = random_drummers.pluck(:id)
      saved_drummer_ids = Choice.select_and_save_drummers(random_drummers, current_user)

      # 保存成功時にセッション情報を更新する
      if saved_drummer_ids.present?
        selected_drummer_ids = saved_drummer_ids
        session[:selected_drummer_ids] = selected_drummer_ids
        session[:latest_genre_user_answer] = @latest_genre_user_answer.id
      end
    end

    # 選択したドラマーのIDを使って表示用のドラマーを取得する
    @drummers = Drummer.where(id: selected_drummer_ids)
  end
end
