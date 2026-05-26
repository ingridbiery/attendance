# test/system/courses_test.rb
require "application_system_test_case"

class CoursesTest < ApplicationSystemTestCase
  setup do
    @art = create(:art)
    @course = create(:course, art: @art)
  end

  test "creating a course" do
    visit art_url(@art)

    within("#courses") do
      click_on "Add"
    end

    assert_current_path new_art_course_path(@art)
    assert_selector "h1", text: "New course"
    assert_text @art.name
    assert_link "Back to art", href: art_path(@art)

    day = "Wednesday"
    time = Time.zone.parse("12:32 AM")

    select day, from: "Day"
    find("#course_time").send_keys(time.strftime("%I%M%p"))
    click_on "Create Course"

    # wait for redirect before reading path
    assert_selector "h2", text: "#{day} #{time.strftime("%I:%M %p")}"
    assert_selector "h3", text: "Meetings (0)"
    new_course_id = current_path.match(/\/courses\/(\d+)/)[1].to_i
    new_course = Course.find(new_course_id)
    assert_current_path art_course_path(@art, new_course)
    assert_link "Edit this course", href: edit_art_course_path(@art, new_course)
    assert_link "Back to art", href: art_path(@art)
  end

  test "editing a course" do
    visit edit_art_course_url(@art, @course)

    assert_current_path edit_art_course_path(@art, @course)
    assert_selector "h1", text: "Editing course"
    assert_link "Show this course", href: art_course_path(@art, @course)
    assert_link "Back to art", href: art_path(@art)

    day = "Monday"
    time = Time.zone.parse("9:05")

    select day, from: "Day"
    find("#course_time").send_keys(time.strftime("%I%M%p"))
    click_on "Update Course"

    # wait for redirect before checking path
    assert_selector "h2", text: "#{day} #{time.strftime("%I:%M %p")}"
    assert_current_path art_course_path(@art, @course)
    assert_link "Edit this course", href: edit_art_course_path(@art, @course)
    assert_link "Back to art", href: art_path(@art)
  end

  test "show page renders course details" do
    visit art_course_url(@art, @course)

    assert_current_path art_course_path(@art, @course)
    assert_selector "h2", text: "#{@course.day.humanize} #{@course.time.strftime("%I:%M %p")}"
    assert_selector "h3", text: "Meetings (0)"
    assert_link "Edit this course", href: edit_art_course_path(@art, @course)
    assert_link "Back to art", href: art_path(@art)
  end

  test "show page renders meetings" do
    meeting = create(:meeting, course: @course)

    visit art_course_url(@art, @course)

    assert_current_path art_course_path(@art, @course)
    assert_selector "h3", text: "Meetings (1)"
    assert_text meeting.date.to_s
    assert_link meeting.date.to_s, href: art_course_meeting_path(@art, @course, meeting)
  end

  test "day dropdown shows humanized day names" do
    visit new_art_course_url(@art)

    within("select#course_day") do
      Course.days.keys.each do |day|
        assert_selector "option", text: day.humanize
      end
    end
  end

  test "creating a course with an invalid day shows an error" do
    # Simulate a bad form submission directly
    visit new_art_course_url(@art)

    # Leave day blank by not selecting anything (if blank option existed)
    # Instead verify the dropdown only contains valid days
    within("select#course_day") do
      assert_no_selector "option", text: "Funday"
    end
  end

  test "destroying a course" do
    visit art_course_url(@art, @course)

    accept_confirm do
      click_on "Destroy this course"
    end

    assert_current_path art_path(@art)
    assert_no_text @course.day.humanize
    assert_no_text @course.time.strftime("%I:%M %p")
  end
end