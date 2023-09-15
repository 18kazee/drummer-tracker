require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'バリデーション' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let(:like) { create(:like, user:, post:) }

    context 'when user_idとpost_idの組み合わせがユニークであること' do
      let(:duplicate_like) { build(:like, user:, post:) }

      before do
        like
      end

      it 'エラーになること' do
        expect(duplicate_like).not_to be_valid
      end

      it 'エラーメッセージが正しく表示されること' do
        duplicate_like.valid?
        expect(duplicate_like.errors[:user_id]).to include('はすでに存在します')
      end
    end
  end
end
