require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーション' do
    describe 'presenceバリデーションの検証' do
      it { is_expected.to validate_presence_of(:tweet) }
      it { is_expected.to validate_presence_of(:user_id) }
      it { is_expected.to validate_presence_of(:drummer_id) }
    end

    describe 'lengthバリデーションの検証' do
      it { is_expected.to validate_length_of(:tweet).is_at_most(140) }
    end
  end

  describe 'アソシエーション' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:drummer) }
    it { is_expected.to belong_to(:room) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end
end
