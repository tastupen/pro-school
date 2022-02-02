require 'rails_helper'

RSpec.describe type: :system do
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }

  describe "chat CRUD" do
    describe "userでlogin" do
      before { sign_in(user) }
      let!(:admin) { create(:admin) }
      context 'フォームの入力値が正常' do
        it '送信に成功' do
          visit chattop_index_path
          click_button 'トークする'
          fill_in "chatcontent", with: "こんにちは"
          click_button 'メッセージを送る'
          expect(page).to have_content "こんにちは"
        end
      end
    end
    describe "adminでlogin" do
      before { sign_in(admin) }
      let!(:user) { create(:user) }
      context 'フォームの入力値が正常' do
        it '送信に成功' do
          visit chattop_index_path
          click_button 'トークする'
          fill_in "chatcontent", with: "こんにちは"
          click_button 'メッセージを送る'
          expect(page).to have_content "こんにちは"
        end
      end
    end
  end
end