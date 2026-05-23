require "application_system_test_case"

class MeetingsTest < ApplicationSystemTestCase
  setup do
    @art = create(:art)
    @course = create(:course, art: @art)
    @meeting = create(:meeting, course: @course)
  end

  test "creating a meeting" do
    visit art_courses_url(@art, @course)

    click_link "New", href: new_art_course_meeting_path(@art, @course)

    assert_selector "h1", text: "New meeting for #{@art.abbrev} #{@course.day}"

    meeting_params = attributes_for(:meeting)

    fill_in "Date", with: meeting_params[:date]
    click_on "Create Meeting"

    assert_text meeting_params[:date]
  end

  test "show page displays meeting date" do
    visit art_course_meeting_url(@art, @course, @meeting)

    assert_selector "h2", text: @meeting.date.to_s
    assert_link "Back to course"
  end

  test "destroying a meeting" do
    visit art_course_meeting_url(@art, @course, @meeting)

    accept_confirm do
      click_on "Destroy this meeting"
    end

    assert_current_path art_course_path(@art, @course)
    assert_selector "h3", text: "Meetings (0)"
  end
end