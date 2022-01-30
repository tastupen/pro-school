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
            expect(page).to have_content 'Email translation missing: ja.activerecord.errors.models.user.attributes.email.taken'
          end
        end
      end
    end

  end
end