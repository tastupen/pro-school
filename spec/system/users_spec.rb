require 'rails_helper'

RSpec.describe User, type: :system do
  let(:user) { create(:user) }

  describe 'User CRUD' do
    describe 'ログイン前' do
      describe 'ユーザー新規登録' do
        context 'フォームの入力値が正常' do
          it 'ユーザーの新規作成が成功' do
            visit new_user_registration_path
            fill_in '名前', with: "テスト"
            fill_in 'メールアドレス', with: 'test@example.com'
            # Passwordテキストフィールドにpasswordと入力
            fill_in 'パスワード', with: 'password'
            # Password confirmationテキストフィールドにpasswordと入力
            fill_in 'パスワード(確認)', with: 'password'
            # SignUpと記述のあるsubmitをクリックする
            click_button 'アカウント作成'
            #ログインしたことを確認する
            expect(page).to have_current_path root_path
          end
        end
        context '名前が空欄' do
          it 'ユーザーの新規作成が失敗' do
            visit new_user_registration_path
            fill_in '名前', with: nil
            fill_in 'メールアドレス', with: 'test@example.com'
            # Passwordテキストフィールドにpasswordと入力
            fill_in 'パスワード', with: 'password'
            # Password confirmationテキストフィールドにpasswordと入力
            fill_in 'パスワード(確認)', with: 'password'
            # SignUpと記述のあるsubmitをクリックする
            click_button 'アカウント作成'
            #ログインしたことを確認する
            expect(page).to have_current_path new_user_registration_path
          end
        end
        context 'メールアドレスが空欄' do
          it 'ユーザーの新規作成が失敗' do
            visit new_user_registration_path
            fill_in '名前', with: "テスト"
            fill_in 'メールアドレス', with: nil
            # Passwordテキストフィールドにpasswordと入力
            fill_in 'パスワード', with: 'password'
            # Password confirmationテキストフィールドにpasswordと入力
            fill_in 'パスワード(確認)', with: 'password'
            # SignUpと記述のあるsubmitをクリックする
            click_button 'アカウント作成'
            #ログインしたことを確認する
            expect(page).to have_current_path new_user_registration_path
          end
        end
        context 'パスワードが空欄' do
          it 'ユーザーの新規作成が失敗' do
            visit new_user_registration_path
            fill_in '名前', with: "テスト"
            fill_in 'メールアドレス', with: 'test@example.com'
            # Passwordテキストフィールドにpasswordと入力
            fill_in 'パスワード', with: nil
            # Password confirmationテキストフィールドにpasswordと入力
            fill_in 'パスワード(確認)', with: 'password'
            # SignUpと記述のあるsubmitをクリックする
            click_button 'アカウント作成'
            #ログインしたことを確認する
            expect(page).to have_content "2 件のエラーが発生したため user は保存されませんでした"
          end
        end
        context '登録済メールアドレス' do
          it 'ユーザーの新規作成が失敗' do
            visit new_user_registration_path
            fill_in '名前', with: "テスト"
            fill_in 'メールアドレス', with: user.email
            # Passwordテキストフィールドにpasswordと入力
            fill_in 'パスワード', with: 'password'
            # Password confirmationテキストフィールドにpasswordと入力
            fill_in 'パスワード(確認)', with: 'password'
            # SignUpと記述のあるsubmitをクリックする
            click_button 'アカウント作成'
            #ログインしたことを確認する
            expect(page).to have_current_path new_user_registration_path
          end
        end
      end
    end
    describe 'ログイン後' do
      before { sign_in(user) }
      describe 'アカウント編集' do
        context '名前の入力値が正常' do
          it 'アカウント編集に成功' do
            visit mypage_edit_users_path
            find(".userNameEditLabel").click
            fill_in 'name', with: "テスト"
            click_button "保存"
            expect(page).to have_current_path mypage_users_path
          end
        end
        context 'メールアドレスの入力値が正常' do
          it 'アカウント編集に成功' do
            visit mypage_edit_users_path
            find(".userMailEditLabel").click
            fill_in 'email', with: "test@example.com"
            click_button "保存"
            expect(page).to have_current_path mypage_users_path
          end
        end
        context '名前が空欄' do
          it 'アカウント編集に失敗' do
            visit mypage_edit_users_path
            find(".userNameEditLabel").click
            fill_in 'name', with: nil
            click_button "保存"
            expect(page).to have_current_path mypage_edit_users_path
          end
        end
        context 'メールが空欄' do
          it 'アカウント編集に失敗' do
            visit mypage_edit_users_path
            find(".userMailEditLabel").click
            fill_in 'email', with: nil
            click_button "保存"
            expect(page).to have_current_path mypage_edit_users_path
          end
        end
      end
      describe 'パスワード編集' do
        context 'フォームの入力値が正常' do
          it 'パスワードに更新成功' do
            visit mypage_edit_password_users_path
            fill_in "password", with: "222222"
            fill_in "password_confirmation", with: "222222"
            click_button "パスワード更新"
            expect(page).to have_current_path new_user_session_path
          end
        end
        context 'パスワードが空欄' do
          it 'パスワードの更新に失敗' do
            visit mypage_edit_password_users_path
            fill_in "password", with: nil
            fill_in "password_confirmation", with: "333333"
            click_button "パスワード更新"
            expect(page).to have_content "パスワードに不備があります。"
          end
        end
        context '確認が空欄' do
          it 'パスワードの更新に失敗' do
            visit mypage_edit_password_users_path
            fill_in "password", with: "222222"
            fill_in "password_confirmation", with: nil
            click_button "パスワード更新"
            expect(page).to have_content "パスワードに不備があります。"
          end
        end
      end
    end
  end
end