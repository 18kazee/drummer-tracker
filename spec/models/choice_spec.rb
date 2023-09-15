require 'rails_helper'

RSpec.describe Choice, type: :model do
  describe 'アソシエーション' do
    it { is_expected.to belong_to(:question) }
    it { is_expected.to have_many(:user_answers).dependent(:destroy) }
  end
end
