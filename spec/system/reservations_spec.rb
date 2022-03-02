require 'rails_helper'

RSpec.describe Reservation, type: :system do
  let(:admin) { create(:admin) }
  let!(:category) { create(:category) }
  let!(:user) { create(:user)}
  describe "reservation CRUD" do
    describe "予約成功" do
      before { sign_in(admin) }
      context 'フォームの入力値が正常' do
        it "投稿に成功" do
          visit new_dashboard_lesson_path
          fill_in 'name', with: "クロール"
          fill_in 'description', with: "初級コースです"
          fill_in 'price', with: "5000"
          select '水泳', from: 'category_id'
          click_button 'レッスン登録'
          visit new_reservation_path
          select 'クロール', from: 'lesson_id'
          select 'test', from: 'user_id'
          select '2022', from: '[start_time(1i)]'
          select '2月', from: '[start_time(2i)]'
          select '15', from: '[start_time(3i)]'
          select '14', from: '[start_time(4i)]'
          select '15', from: '[start_time(5i)]'
          click_button 'レッスン登録'
          expect(page).to have_content "レッスン予約が完了しました。"
        end
      end
      context "フォームが空" do
        it "投稿に失敗" do
          visit new_dashboard_lesson_path
          fill_in 'name', with: "クロール"
          fill_in 'description', with: "初級コースです"
          fill_in 'price', with: "5000"
          select '水泳', from: 'category_id'
          click_button 'レッスン登録'
          visit new_reservation_path
          select '', from: 'lesson_id'
          select 'test', from: 'user_id'
          select '2022', from: '[start_time(1i)]'
          select '2月', from: '[start_time(2i)]'
          select '15', from: '[start_time(3i)]'
          select '14', from: '[start_time(4i)]'
          select '15', from: '[start_time(5i)]'
          click_button 'レッスン登録'
          expect(page).to have_content "レッスン予約に失敗しました。"
        end
      end
      context "フォームが空" do
        it "投稿に失敗" do
          visit new_dashboard_lesson_path
          fill_in 'name', with: "クロール"
          fill_in 'description', with: "初級コースです"
          fill_in 'price', with: "5000"
          select '水泳', from: 'category_id'
          click_button 'レッスン登録'
          visit new_reservation_path
          select 'クロール', from: 'lesson_id'
          select '', from: 'user_id'
          select '2022', from: '[start_time(1i)]'
          select '2月', from: '[start_time(2i)]'
          select '15', from: '[start_time(3i)]'
          select '14', from: '[start_time(4i)]'
          select '15', from: '[start_time(5i)]'
          click_button 'レッスン登録'
          expect(page).to have_content "レッスン予約に失敗しました。"
        end
      end
      context "予約時間が被り" do
        it "投稿に失敗" do
          visit new_dashboard_lesson_path
          fill_in 'name', with: "クロール"
          fill_in 'description', with: "初級コースです"
          fill_in 'price', with: "5000"
          select '水泳', from: 'category_id'
          click_button 'レッスン登録'
          visit new_reservation_path
          select 'クロール', from: 'lesson_id'
          select 'test', from: 'user_id'
          select '2022', from: '[start_time(1i)]'
          select '2月', from: '[start_time(2i)]'
          select '15', from: '[start_time(3i)]'
          select '14', from: '[start_time(4i)]'
          select '15', from: '[start_time(5i)]'
          click_button 'レッスン登録'
          visit new_reservation_path
          select 'クロール', from: 'lesson_id'
          select 'test', from: 'user_id'
          select '2022', from: '[start_time(1i)]'
          select '2月', from: '[start_time(2i)]'
          select '15', from: '[start_time(3i)]'
          select '14', from: '[start_time(4i)]'
          select '15', from: '[start_time(5i)]'
          click_button 'レッスン登録'
          expect(page).to have_content "レッスン予約に失敗しました。"
        end
      end
    end
    describe "予約時間編集" do
      let(:lesson) {create(:lesson, admin: asmin, category: category)}
      let(:reservation) { create(:reservation, user: user, lesson: lesson, admin:admin) }
      before { sign_in(admin) }
      before { edit_reservation_path(reservation)}
      context "レッスン時間の編集" do
        it "編集に成功" do
          select 'クロール', from: 'lesson_id'
          select 'test', from: 'user_id'
          select '2022', from: '[start_time(1i)]'
          select '2月', from: '[start_time(2i)]'
          select '15', from: '[start_time(3i)]'
          select '16', from: '[start_time(4i)]'
          select '30', from: '[start_time(5i)]'
          click_button 'レッスン登録'
          expect(page).to have_content "レッスンの更新に成功しました。"
        end
      end
    end
  end
end