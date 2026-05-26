# test/system/meetings_test.rb
require "application_system_test_case"

class MeetingsTest < ApplicationSystemTestCase
  setup do
    @art = create(:art)
    @course = create(:course, art: @art)
    @meeting = create(:meeting, course: @course)
  end

  test "creating a meeting" do
    visit art_course_url(@art, @course)

    click_link "Add", href: new_art_course_meeting_path(@art, @course)

    assert_current_path new_art_course_meeting_path(@art, @course)
    assert_selector "h1", text: "New meeting for #{@art.abbrev} #{@course.day.humanize}"
    assert_link "Back to course", href: art_course_path(@art, @course)

    date = Date.today()-1

    find("#meeting_date").send_keys(date.strftime("%m%d%Y"))
    click_on "Save Attendance"

    # wait for redirect before reading path
    assert_selector "h2", text: "#{date} #{@course}"
    new_meeting_id = current_path.match(/\/meetings\/(\d+)/)[1].to_i
    new_meeting = Meeting.find(new_meeting_id)
    assert_current_path art_course_meeting_path(@art, @course, new_meeting)
    assert_link "Back to course", href: art_course_path(@art, @course)
  end

  test "creating a meeting without a date shows an error" do
    visit new_art_course_meeting_url(@art, @course)

    # clear date (it defaults to today)
    fill_in "Date", with: ""

    click_on "Save Attendance"

    assert_text "Date can't be blank"
    assert_selector "form"
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
    assert_text "Meeting was successfully destroyed"
  end
end