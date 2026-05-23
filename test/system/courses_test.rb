# test/system/courses_test.rb
require "application_system_test_case"

class CoursesTest < ApplicationSystemTestCase
  setup do
    @art = create(:art)
    @course = create(:course, art: @art)
  end

  test "visiting the index" do
    visit art_courses_url(@art)

    assert_current_path art_courses_path(@art)
    assert_selector "h1", text: "Courses"
    assert_text @course.day
    assert_text @course.time.strftime("%I:%M %p")
    assert_link "Add", href: new_art_course_path(@art)
    assert_link "Show this course", href: art_course_path(@art, @course)
    assert_link "New", href: new_art_course_meeting_path(@art, @course)
    assert_link "Show", href: art_course_path(@art, @course)
    assert_link "Edit", href: edit_art_course_path(@art, @course)
    assert_link "Back to art", href: art_path(@art)
  end

  test "creating a course" do
    visit art_courses_url(@art)

    within("#add-course") do
      click_on "Add"
    end

    assert_current_path new_art_course_path(@art)
    assert_selector "h1", text: "New course"
    assert_text @art.name
    assert_link "Back to art", href: art_path(@art)

    course_params = attributes_for(:course)

    select course_params[:day], from: "Day"
    fill_in "Time", with: course_params[:time].strftime("%H:%M")
    click_on "Create Course"

    # put these first so we wait for the page to load before checking the path
    assert_selector "h2", text: "#{course_params[:day]} #{course_params[:time].strftime("%I:%M %p")}"
    assert_selector "h3", text: "Meetings (0)"
    new_course_id = current_path.split("/").last.to_i
    new_course = Course.find(new_course_id)
    assert_current_path art_course_path(@art, new_course)
    assert_link "Edit this course", href: edit_art_course_path(@art, Course.last)
    assert_link "Back to art", href: art_path(@art)
  end

  test "editing a course" do
    visit edit_art_course_url(@art, @course)

    assert_current_path edit_art_course_path(@art, @course)
    assert_selector "h1", text: "Editing course"
    assert_link "Show this course", href: art_course_path(@art, @course)
    assert_link "Back to art", href: art_path(@art)

    course_params = attributes_for(:course)

    select course_params[:day], from: "Day"
    fill_in "Time", with: course_params[:time].strftime("%H:%M")
    click_on "Update Course"

    # put these first so we wait for the page to load before checking the path
    assert_selector "h2", text: "#{course_params[:day]} #{course_params[:time].strftime("%I:%M %p")}"
    assert_current_path art_course_path(@art, @course)
    assert_link "Edit this course", href: edit_art_course_path(@art, @course)
    assert_link "Back to art", href: art_path(@art)
  end

  test "show page renders course details" do
    visit art_course_url(@art, @course)

    assert_current_path art_course_path(@art, @course)
    assert_selector "h2", text: "#{@course.day} #{@course.time.strftime("%I:%M %p")}"
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

  test "index page shows new meeting link" do
    visit art_courses_url(@art)

    within("#courses") do
      assert_link "New", href: new_art_course_meeting_path(@art, @course)
    end
  end

  test "destroying a course" do
    visit art_course_url(@art, @course)

    accept_confirm do
      click_on "Destroy this course"
    end

    assert_current_path art_path(@art)
    assert_no_text @course.day
    assert_no_text @course.time.strftime("%I:%M %p")
  end
end