require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーション' do
    it { is_expected.to validate_presence_of :body }
    it { is_expected.to validate_length_of(:body).is_at_most(655) }
  end
end
