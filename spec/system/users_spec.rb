require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user, :activated) }

  describe 'ユーザー新規作成' do
    before do
      visit new_user_path
      fill_in 'user_name', with: 'test'
      fill_in 'user_email', with: 'example@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
    end

    context 'when 正常な入力値の場合' do
      it 'ユーザーの新規作成ができる' do
        click_button '登録'
        expect(page).to have_content '登録用のメールを送信しました。メールをご確認ください。'
      end

      it '正しいページにリダイレクトされる' do
        click_button '登録'
        expect(page).to have_current_path login_path, ignore_query: true
      end
    end

    context 'when ユーザー名が空の場合' do
      before do
        fill_in 'user_name', with: ''
        click_button '登録'
      end

      it 'エラーメッセージが表示される' do
        expect(page).to have_content '名前を入力してください'
      end

      it '登録に失敗するメッセージが表示される' do
        expect(page).to have_content '登録に失敗しました'
      end

      it '新規登録ページにリダイレクトされる' do
        expect(page).to have_current_path new_user_path, ignore_query: true
      end
    end

    context 'when メールアドレスが空の場合' do
      before do
        fill_in 'user_email', with: ''
        click_button '登録'
      end

      it 'エラーメッセージが表示される' do
        expect(page).to have_content 'メールアドレスを入力してください'
      end

      it '登録に失敗するメッセージが表示される' do
        expect(page).to have_content '登録に失敗しました'
      end

      it '新規登録ページにリダイレクトされる' do
        expect(page).to have_current_path new_user_path, ignore_query: true
      end
    end

    context 'when パスワードが空欄の場合' do
      before do
        fill_in 'user_password', with: ''
        click_button '登録'
      end

      it 'エラーメッセージが表示される' do
        expect(page).to have_content 'パスワードを入力してください'
      end

      it '登録に失敗するメッセージが表示される' do
        expect(page).to have_content '登録に失敗しました'
      end

      it '新規登録ページにリダイレクトされる' do
        expect(page).to have_current_path new_user_path, ignore_query: true
      end
    end

    context 'when パスワード(確認)が空欄の場合' do
      before do
        fill_in 'user_password_confirmation', with: ''
        click_button '登録'
      end

      it 'エラーメッセージが表示される' do
        expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
      end

      it '確認用エラーメッセージが表示される' do
        expect(page).to have_content 'パスワード（確認用）を入力してください'
      end

      it '登録に失敗するメッセージが表示される' do
        expect(page).to have_content '登録に失敗しました'
      end

      it '新規登録ページにリダイレクトされる' do
        expect(page).to have_current_path new_user_path, ignore_query: true
      end
    end
  end

  describe 'ユーザーの編集' do
    before do
      login(user)
      click_link 'マイページ'
      click_link 'profile'
      click_link '編集'
    end

    context 'when 正常な入力値の時' do
      before do
        fill_in '名前', with: 'test'
        fill_in 'プロフィール', with: 'test'
        click_button '更新する'
      end

      it 'ユーザーの編集が成功する' do
        expect(page).to have_content 'プロフィールを更新しました'
      end

      it '正しいページにリダイレクトされる' do
        expect(page).to have_current_path user_path(user), ignore_query: true
      end
    end

    context 'when ユーザー名が空の時' do
      before do
        fill_in '名前', with: ''
        fill_in 'プロフィール', with: 'test'
        click_button '更新する'
      end

      it 'エラーメッセージが表示される' do
        expect(page).to have_content '名前を入力してください'
      end

      it '編集に失敗するメッセージが表示される' do
        expect(page).to have_current_path user_path(user), ignore_query: true
      end
    end
  end
end
