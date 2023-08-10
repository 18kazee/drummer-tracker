class RecommendedDrummersController < ApplicationController
  skip_before_action :redirect_if_logged_in

def index
  @latest_genre_user_answer = current_user.user_answers.where(question_id: 1).last
  if @latest_genre_user_answer.present?
    user_selected_genres = determine_user_genres(@latest_genre_user_answer)
    all_drummers = user_selected_genres.flat_map(&:drummers)

    @latest_music_origin_answer = current_user.user_answers.where(question_id: 2).last
    if @latest_music_origin_answer.present?
      choice = Choice.find(@latest_music_origin_answer.choice_id)
      filtered_drummers = filter_drummers_by_country(all_drummers, choice.content)

      # セッションから選択したドラマーのIDを取得する
      selected_drummer_ids = session[:selected_drummer_ids] || []

  if session[:question_1_answered] != @latest_genre_user_answer.id
    # 新しいランダムなドラマーを選択し、セッションに記録する
    random_drummers = filtered_drummers.sample(3)
    selected_drummer_ids = random_drummers.pluck(:id)

    # ドラマーを保存し、保存できたIDを取得する
    saved_drummer_ids = select_and_save_drummers(random_drummers)

    # 保存が成功しているかを確認し、保存できたIDをセッションに保存する
    if saved_drummer_ids.present?
      selected_drummer_ids = saved_drummer_ids
      session[:selected_drummer_ids] = selected_drummer_ids
      session[:question_1_answered] = @latest_genre_user_answer.id
    end
  end

  # 選択したドラマーのIDを使って表示用のドラマーを取得する
  @drummers = Drummer.where(id: selected_drummer_ids)
end
end 
end
  private

  def determine_user_genres(user_answer)
    choice = Choice.find(user_answer.choice_id)
    case choice.content
    when "ポップス系"
      Genre.where(name: ["ポップス", "J-POP", "ポップ"])
    when "ロック系"
      Genre.where(name: ["ロック", "ハードロック", "メタル", "ヘビーメタル", "ヘヴィメタル", "プログレッシブ・ロック", "プログレッシブ", "パンク"])
    when "ジャズ系"
      Genre.where(name: ["ジャズ", "フュージョン", "ブルーズ", "ブルース"])
    when "その他"
      Genre.where.not(name: ["ポップス", "J-POP", "ポップ", "ロック", "ハードロック", "メタル", "ヘビーメタル", "ヘヴィメタル", "プログレッシブ・ロック", "プログレッシブ", "パンク", "ジャズ", "フュージョン", "ブルーズ", "ブルース"])
    else
      nil
    end
  end

  def filter_drummers_by_country(drummers, choice_content)
    case choice_content
    when "邦楽"
      drummers.select { |drummer| drummer.country == 'japan' }
    when "洋楽"
      drummers.select { |drummer| drummer.country == 'abroad' }
    else
      drummers
    end
  end

  def select_and_save_drummers(random_drummers)
    recommended_drummers = []
    random_drummers.each do |drummer|
      recommended_drummer = RecommendedDrummer.new(user_id: current_user.id, drummer_id: drummer.id)
      recommended_drummers << recommended_drummer if recommended_drummer.save
    end
    # 保存したドラマーのIDを返す
    recommended_drummers.map(&:drummer_id)
  end
end