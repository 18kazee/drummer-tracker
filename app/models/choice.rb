class Choice < ApplicationRecord
  belongs_to :question
  has_many :user_answers, dependent: :destroy

  def self.select_user_genres(user_answer)
    choice = Choice.find(user_answer.choice_id)
    case choice.content
    when "ポップス系"
      Genre.where(name: %w[ポップス J-POP ポップ])
    when "ロック系"
      Genre.where(name: ["ロック", "ハードロック", "メタル", "ヘビーメタル", "ヘヴィメタル", "プログレッシブ・ロック", "プログレッシブ", "パンク"])
    when "ジャズ系"
      Genre.where(name: %w[ジャズ フュージョン ブルーズ ブルース])
    when "その他"
      Genre.where.not(name: ["ポップス", "J-POP", "ポップ", "ロック", "ハードロック", "メタル", "ヘビーメタル", "ヘヴィメタル", "プログレッシブ・ロック", "プログレッシブ", "パンク", "ジャズ", "フュージョン", "ブルーズ", "ブルース"])
    end
  end

  def self.filter_drummers_by_country(drummers, choice_content)
    case choice_content
    when "邦楽"
      drummers.select { |drummer| drummer.country == 'japan' }
    when "洋楽"
      drummers.select { |drummer| drummer.country == 'abroad' }
    else
      drummers
    end
  end

  def self.select_and_save_drummers(random_drummers, user)
    recommended_drummers = []
    random_drummers.each do |drummer|
      recommended_drummer = RecommendedDrummer.new(user_id: user.id, drummer_id: drummer.id)
      recommended_drummers << recommended_drummer if recommended_drummer.save
    end
    # 保存したドラマーのIDを返す
    recommended_drummers.map(&:drummer_id)
  end


end
