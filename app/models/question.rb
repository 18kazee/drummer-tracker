class Question < ApplicationRecord
  has_many :user_answers, dependent: :destroy
  has_many :choices, dependent: :destroy

  def next_question
    self.class.where("id > ?", id).order(:id).first
  end

  def previous_question
    self.class.where("id < ?", id).order(:id).first
  end
end
