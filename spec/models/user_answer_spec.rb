require 'rails_helper'

RSpec.describe UserAnswer, type: :model do
  describe 'バリデーション' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:question_id) }
    it { is_expected.to validate_presence_of(:choice_id) }
  end
end
