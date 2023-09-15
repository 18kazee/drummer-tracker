require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'presenceのバリデーション検証' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:password_confirmation) }
  end

  describe 'lengthのバリデーション検証' do
    subject { user }

    let(:user) { build(:user) }

    it { is_expected.to validate_length_of(:name).is_at_most(20) }
    it { is_expected.to validate_length_of(:password).is_at_least(5) }
  end

  describe 'プロフィールのバリデーション' do
    let(:user) { create(:user) }

    context 'when 200文字以内の時' do
      before { user.update(profile: 'a' * 200) }

      it '更新が成功する' do
        expect(user).to be_valid
      end
    end

    context 'when 200文字以上の時' do
      before { user.update(profile: 'a' * 201) }

      it '更新が失敗する' do
        expect(user).to be_invalid
      end

      it 'エラーメッセージが表示される' do
        expect(user.errors.messages[:profile]).to include('は200文字以内で入力してください')
      end
    end
  end

  describe 'uniquenessのバリデーション' do
    before { create(:user) }

    it { is_expected.to validate_uniqueness_of(:email) }
  end

  describe 'アソシエーション' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:liked_posts).through(:likes).source(:post) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:favorites).dependent(:destroy) }
    it { is_expected.to have_many(:favorite_drummers).through(:favorites).source(:drummer) }
    it { is_expected.to have_many(:recommended_drummers).dependent(:destroy) }
    it { is_expected.to have_many(:user_answers).dependent(:destroy) }
    it { is_expected.to have_many(:messages).dependent(:destroy) }
    it { is_expected.to have_many(:user_rooms).dependent(:destroy) }
    it { is_expected.to have_many(:rooms).through(:user_rooms) }
    it { is_expected.to have_many(:diagnosis_results).dependent(:destroy) }
  end

  describe 'enum' do
    it { is_expected.to define_enum_for(:role).with_values(general: 0, admin: 1) }
  end
end
