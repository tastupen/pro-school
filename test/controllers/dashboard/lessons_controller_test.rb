require "test_helper"

class Dashboard::LessonsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dashboard_lessons_index_url
    assert_response :success
  end

  test "should get new" do
    get dashboard_lessons_new_url
    assert_response :success
  end

  test "should get create" do
    get dashboard_lessons_create_url
    assert_response :success
  end

  test "should get edit" do
    get dashboard_lessons_edit_url
    assert_response :success
  end

  test "should get update" do
    get dashboard_lessons_update_url
    assert_response :success
  end

  test "should get destroy" do
    get dashboard_lessons_destroy_url
    assert_response :success
  end
end
