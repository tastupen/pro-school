require 'rails_helper'

RSpec.describe Admin, type: :system do
  let(:admin) { create(:admin) }

  describe 'Admin CRUD' do
    describe 'ログイン前' do
      describe '先生新規登録' do
        context '名前が空欄' do
          it 'ユーザーの新規作成が失敗' do
            visit new_admin_registration_path
            fill_in '名前', with: nil
            fill_in 'メールアドレス', with: 'test@example.com'
            # Passwordテキストフィールドにpasswordと入力
            fill_in 'パスワード', with: 'password'
            # Password confirmationテキストフィールドにpasswordと入力
            fill_in 'パスワード(確認)', with: 'password'
            # SignUpと記述のあるsubmitをクリックする
            click_button 'アカウント作成'
            #ログインしたことを確認する
            expect(page).to have_current_path new_admin_registration_path
          end
        end
        context 'メールアドレスが空欄' do
          it 'ユーザーの新規作成が失敗' do
            visit new_admin_registration_path
            fill_in '名前', with: "テスト"
            fill_in 'メールアドレス', with: nil
            # Passwordテキストフィールドにpasswordと入力
            fill_in 'パスワード', with: 'password'
            # Password confirmationテキストフィールドにpasswordと入力
            fill_in 'パスワード(確認)', with: 'password'
            # SignUpと記述のあるsubmitをクリックする
            click_button 'アカウント作成'
            #ログインしたことを確認する
            expect(page).to have_current_path new_admin_registration_path
          end
        end
        context 'パスワードが空欄' do
          it 'ユーザーの新規作成が失敗' do
            visit new_admin_registration_path
            fill_in '名前', with: "テスト"
            fill_in 'メールアドレス', with: 'test@example.com'
            # Passwordテキストフィールドにpasswordと入力
            fill_in 'パスワード', with: nil
            # Password confirmationテキストフィールドにpasswordと入力
            fill_in 'パスワード(確認)', with: 'password'
            # SignUpと記述のあるsubmitをクリックする
            click_button 'アカウント作成'
            #ログインしたことを確認する
            expect(page).to have_content "2 件のエラーが発生したため admin は保存されませんでした"
          end
        end
        context '登録済メールアドレス' do
          it 'ユーザーの新規作成が失敗' do
            visit new_admin_registration_path
            fill_in '名前', with: "テスト"
            fill_in 'メールアドレス', with: admin.email
            # Passwordテキストフィールドにpasswordと入力
            fill_in 'パスワード', with: 'password'
            # Password confirmationテキストフィールドにpasswordと入力
            fill_in 'パスワード(確認)', with: 'password'
            # SignUpと記述のあるsubmitをクリックする
            click_button 'アカウント作成'
            #ログインしたことを確認する
            expect(page).to have_content 'Email translation missing: ja.activerecord.errors.models.admin.attributes.email.taken'
          end
        end
      end
    end
    describe 'ログイン後' do
      before{ sign_in(admin)}
      describe 'プロフィール編集' do
        context 'フォームの入力値が正常' do
          it 'プロフィールの編集が成功' do
            visit edit_profile_admin_path
            fill_in '名前', with: "テスト"
            fill_in '経歴', with: "日本選手権優勝"
            click_button 'プロフィールを更新'
            expect(page).to have_current_path dashboard_path
          end
        end
        context '名前が空欄' do
          it 'プロフィールの編集が失敗' do 
            visit edit_profile_admin_path
            fill_in '名前', with: nil
            fill_in '経歴', with: "日本選手権優勝"
            click_button 'プロフィールを更新'
            expect(page).to have_current_path edit_profile_admin_path
          end
        end
      end
      describe 'アカウント編集' do
        context 'フォームの入力値が正常' do
          it 'アカウントの編集が成功' do
            visit edit_account_admin_path
            fill_in 'メールアドレス', with: "test1@example.com"
            fill_in 'パスワード', with: "aaaaaa"
            fill_in 'パスワード(確認)', with: "aaaaaa"
            click_button 'アカウント更新'
            expect(page).to have_current_path dashboard_path
          end
        end
        context 'メールアドレスが空欄' do
          it 'アカウントの編集が失敗' do
            visit edit_account_admin_path
            fill_in 'メールアドレス', with: nil
            fill_in 'パスワード', with: "aaaaaa"
            fill_in 'パスワード(確認)', with: "aaaaaa"
            click_button 'アカウント更新'
            expect(page).to have_current_path edit_account_admin_path
          end
        end
        context 'パスワードが空欄' do
          it 'アカウントの編集が失敗' do
            visit edit_account_admin_path
            fill_in 'メールアドレス', with: nil
            fill_in 'パスワード', with: nil
            fill_in 'パスワード(確認)', with: "aaaaaa"
            click_button 'アカウント更新'
            expect(page).to have_current_path edit_account_admin_path
          end
        end
      end
    end
  end
end