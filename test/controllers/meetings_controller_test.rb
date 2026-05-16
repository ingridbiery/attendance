require "test_helper"

class MeetingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @art = create(:art)
    @course = create(:course, art: @art)
    @meeting = create(:meeting, course: @course, art: @art)
  end

  test "should get new" do
    get new_art_course_meeting_url(@art, @course)
    assert_response :success
  end

  test "should create meeting" do
    meeting_params = attributes_for(:meeting, art: @art, course: @course)

    assert_difference("Meeting.count") do
      post art_course_meetings_url(@art, @course), params: {
        meeting: meeting_params
      }
    end

    assert_redirected_to art_course_meeting_url(@art, @course, Meeting.last)
  end

  test "should show meeting" do
    get art_course_meeting_url(@art, @course, @meeting)
    assert_response :success
  end

  test "should destroy meeting" do
    assert_difference("Meeting.count", -1) do
      delete art_course_meeting_url(@art, @course, @meeting)
    end

    assert_redirected_to art_course_url(@art, @course)
  end
end