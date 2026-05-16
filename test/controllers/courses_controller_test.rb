require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @art = create(:art)
    @course = create(:course, art: @art)
  end

  test "should get index" do
    get art_courses_url(@art)
    assert_response :success
  end

  test "should get new" do
    get new_art_course_url(@art)
    assert_response :success
  end

  test "should create course" do
    course_params = attributes_for(:course, art: @art)

    assert_difference("Course.count") do
      post art_courses_url(@art), params: {
        course: course_params
      }
    end

    assert_redirected_to art_course_url(@art, Course.last)
  end

  test "should show course" do
    get art_course_url(@art, @course)
    assert_response :success
  end

  test "should get edit" do
    get edit_art_course_url(@art, @course)
    assert_response :success
  end

  test "should update course" do
    course_params = attributes_for(:course, art: @art)

    patch art_course_url(@art, @course), params: {
      course: course_params
    }

    assert_redirected_to art_course_url(@art, @course)
  end

  test "should destroy course" do
    assert_difference("Course.count", -1) do
      delete art_course_url(@art, @course)
    end

    assert_redirected_to art_url(@art)
  end
end