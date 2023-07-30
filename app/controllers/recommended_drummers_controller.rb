class RecommendedDrummersController < ApplicationController
  skip_before_action :redirect_if_logged_in

  def index
    @user_answer_1 = current_user.user_answers.where(question_id: 1).last
    if @user_answer_1.present?
      genres_for_question_1 = determine_user_genres(@user_answer_1)
      all_drummers = genres_for_question_1.flat_map(&:drummers)

      @user_answer_2 = current_user.user_answers.where(question_id: 2).last
      if @user_answer_2.present?
        choice = Choice.find(@user_answer_2.choice_id)
        filtered_drummers = filter_drummers_by_country(all_drummers, choice.content)
        random_drummers = filtered_drummers.sample(3)
        @drummers = random_drummers
      end
    else
      redirect_to question_path
    end
  end

  private

  def determine_user_genres(user_answer)
    choice = Choice.find(user_answer.choice_id)
    case choice.content
    when "ポップス系"
      Genre.where(name: ["ポップス", "J-POP", "ポップ", "JーPOP"])
    when "ロック系"
      Genre.where(name: ["ロック", "ハードロック", "メタル", "ヘビーメタル", "ヘヴィメタル", "プログレッシブ・ロック", "プログレッシブ", "パンク"])
    when "ジャズ系"
      Genre.where(name: ["ジャズ", "フュージョン", "ブルーズ", "ブルース"])
    when "その他"
      Genre.where.not(name: ["ポップス", "J-POP", "ポップ", "JーPOP", "ロック", "ハードロック", "メタル", "ヘビーメタル", "ヘヴィメタル", "プログレッシブ・ロック", "プログレッシブ", "パンク", "ジャズ", "フュージョン", "ブルーズ", "ブルース"])
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
end
