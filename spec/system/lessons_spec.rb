require 'rails_helper'

RSpec.describe Lesson, type: :system do
  let(:admin) { create(:admin) }
  let!(:category) { create(:category) }

  describe "lesson CRUD" do
    describe "レッスン投稿"  do
      before { sign_in(admin) }
      context 'フォームの入力値が正常' do
        it "投稿に成功" do
          visit new_dashboard_lesson_path
          fill_in 'name', with: "クロール"
          fill_in 'description', with: "初級コースです"
          fill_in 'price', with: "5000"
          select '水泳', from: 'category_id'
          click_button 'レッスン登録'
          expect(page).to have_current_path dashboard_lessons_path
        end
      end
      context 'レッスン名が空欄' do
        it "投稿に失敗" do
          visit new_dashboard_lesson_path
          fill_in 'name', with: nil
          fill_in 'description', with: "初級コースです"
          fill_in 'price', with: "5000"
          select '水泳', from: 'category_id'
          click_button 'レッスン登録'
          expect(page).to have_current_path new_dashboard_lesson_path
        end
      end
      context '説明が空欄' do
        it "投稿に失敗" do
          visit new_dashboard_lesson_path
          fill_in 'name', with: "クロール"
          fill_in 'description', with: nil
          fill_in 'price', with: "5000"
          select '水泳', from: 'category_id'
          click_button 'レッスン登録'
          expect(page).to have_current_path new_dashboard_lesson_path
        end
      end
      context '値段が空欄' do
        it "投稿に失敗" do
          visit new_dashboard_lesson_path
          fill_in 'name', with: "クロール"
          fill_in 'description', with: "初級コースです"
          fill_in 'price', with: nil
          select '水泳', from: 'category_id'
          click_button 'レッスン登録'
          expect(page).to have_current_path new_dashboard_lesson_path
        end
      end
      context 'カテゴリーが空欄' do
        it "投稿に失敗" do
          visit new_dashboard_lesson_path
          fill_in 'name', with: "クロール"
          fill_in 'description', with: "初級コースです"
          fill_in 'price', with: "5000"
          select '', from: 'category_id'
          click_button 'レッスン登録'
          expect(page).to have_current_path new_dashboard_lesson_path
        end
      end
    end
    describe "レッスン編集"  do
      before { sign_in(admin) }
      context 'フォームの入力値が正常' do
        it "投稿に成功" do
          visit new_dashboard_lesson_path
          fill_in 'name', with: "クロール"
          fill_in 'description', with: "初級コースです"
          fill_in 'price', with: "5000"
          select '水泳', from: 'category_id'
          click_button 'レッスン登録'
          visit dashboard_lessons_path
          click_button 'edit'
          fill_in 'lesson[name]', with: "クロール"
          fill_in 'lesson[description]', with: "初級コースです"
          fill_in 'lesson[price]', with: "6000"
          select '水泳', from: 'lesson[category_id]'
          click_button '更新する'
          expect(page).to have_current_path dashboard_lessons_path
        end
      end
    end
  end
end