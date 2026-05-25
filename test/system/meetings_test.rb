# test/system/meetings_test.rb
require "application_system_test_case"

class MeetingsTest < ApplicationSystemTestCase
  setup do
    @art = create(:art)
    @course = create(:course, art: @art)
    @meeting = create(:meeting, course: @course)
  end

  test "creating a meeting" do
    visit art_courses_url(@art)

    click_link "New", href: new_art_course_meeting_path(@art, @course)

    assert_current_path new_art_course_meeting_path(@art, @course)
    assert_selector "h1", text: "New meeting for #{@art.abbrev} #{@course.day.humanize}"
    assert_link "Back to course", href: art_course_path(@art, @course)

    meeting_params = attributes_for(:meeting)

    find("#meeting_date").send_keys(meeting_params[:date].strftime("%m%d%Y"))
    click_on "Create Meeting"

    # put these first so we wait for the page to load before finding the id
    assert_selector "h2", text: meeting_params[:date].to_s
    new_meeting_id = current_path.split("/").last.to_i
    new_meeting = Meeting.find(new_meeting_id)
    assert_current_path art_course_meeting_path(@art, @course, new_meeting)
    assert_link "Back to course", href: art_course_path(@art, @course)
  end

  test "show page renders meeting details" do
    visit art_course_meeting_url(@art, @course, @meeting)

    assert_current_path art_course_meeting_path(@art, @course, @meeting)
    assert_selector "h2", text: @meeting.date.to_s
    assert_link "Back to course", href: art_course_path(@art, @course)
  end

  test "destroying a meeting" do
    visit art_course_meeting_url(@art, @course, @meeting)

    accept_confirm do
      click_on "Destroy this meeting"
    end

    assert_current_path art_course_path(@art, @course)
    assert_selector "h3", text: "Meetings (0)"
    assert_no_text @meeting.date.to_s
  end
end