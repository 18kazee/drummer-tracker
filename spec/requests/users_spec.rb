require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user, :activated) }

  describe "ger /new" do
    context "when user is not logged in" do
      it "成功すること" do
        get new_user_path
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "POST /create" do
    context "with valid attributes" do
      let(:user_attributes) { attributes_for(:user) }

      it "ユーザーを作成できること" do
        expect do
          post users_path, params: { user: user_attributes }
        end.to change(User, :count).by(1)
      end

      it "ログインページにリダイレクトすること" do
        post users_path, params: { user: user_attributes }
        expect(response).to redirect_to login_path
      end
    end

    context "with invalid attributes" do
      let(:user_attributes) { attributes_for(:user, email: "") }

      it "ユーザーを作成できないこと" do
        expect do
          post users_path, params: { user: user_attributes }
        end.not_to change(User, :count)
      end

      it "ステータスがunprocessable entityであること " do
        post users_path, params: { user: user_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /edit" do
    context "when user is not logged in" do
      it "ログインページにリダイレクトすること" do
        get edit_user_path(user)
        expect(response).to redirect_to login_path
      end
    end

    context "when user is logged in" do
      before do
        login_user(user, '123456', login_path)
      end

      it "自分の編集ページにアクセスできること" do
        get edit_user_path(user)
        expect(response).to have_http_status(:success)
      end

      it "他人の編集ページにアクセスできないこと" do
        other_user = create(:user, :activated)
        get edit_user_path(other_user)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "PATCH /update" do
    let(:user_attributes) { attributes_for(:user, name: "New Name") }

    before do
      login_user(user, '123456', login_path)
      get edit_user_path(user)
    end

    it "自分のユーザー情報を更新できること" do
      patch user_path(user), params: { user: user_attributes }
      expect(user.reload.name).to eq "New Name"
    end

    it "他人のユーザー情報を更新できないこと" do
      other_user = create(:user, :activated)
      patch user_path(other_user), params: { user: user_attributes }
      expect(other_user.reload.name).not_to eq "New Name"
    end
  end

  describe "GET /likes" do
    before do
      login_user(user, '123456', login_path)
    end

    it "ユーザーの「いいね」一覧ページが正しく表示されること" do
      get likes_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /favorites" do
    before do
      login_user(user, '123456', login_path)
    end

    it "ユーザーの「お気に入り」一覧ページが正しく表示されること" do
      get favorites_user_path(user)
      expect(response).to have_http_status(:success)
    end

    it "他人の「お気に入り」一覧ページにアクセスできないこと" do
      other_user = create(:user, :activated)
      get favorites_user_path(other_user)
      expect(response).to redirect_to root_path
    end
  end

  describe "GET /activate" do
    let!(:user) { create(:user) }

    before do
      allow(User).to receive(:load_from_activation_token).with(user.activation_token).and_return(user)
    end

    describe "before activation" do
      it "ステータスがpendingであること" do
        expect(user.reload.activation_state).to eq "pending"
      end
    end

    describe "アクティベーション後" do
      before { get activate_user_path(id: user.activation_token) }

      it "ステータスがactiveであること" do
        expect(user.reload.activation_state).to eq "active"
      end

      it "ログインページにリダイレクトすること" do
        expect(response).to redirect_to(login_path)
      end

      it "フラッシュメッセージが表示されること" do
        expect(flash[:success]).to eq '会員登録が完了しました。'
      end
    end
  end

  describe "POST /resend_activation" do
    let!(:user) { create(:user) }

    before do
      ActionMailer::Base.deliveries.clear
    end

    context "when user is not activated" do
      it "メール送信前の数が0であること" do
        expect(ActionMailer::Base.deliveries.size).to eq 0
      end

      it "メールを1つ送信した後の数が1になること" do
        post resend_activation_path, params: { email: user.email }
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end

      it "送信者が自分のメールアドレスであること" do
        post resend_activation_path, params: { email: user.email }
        mail = ActionMailer::Base.deliveries.last
        expect(mail.to).to eq [user.email]
      end

      it "送信したメールの件名が正しいこと" do
        post resend_activation_path, params: { email: user.email }
        mail = ActionMailer::Base.deliveries.last
        expect(mail.subject).to eq "DrummerTrackerアカウントの認証"
      end
    end
  end
end
