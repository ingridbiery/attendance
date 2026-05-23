require "application_system_test_case"

class CoursesTest < ApplicationSystemTestCase
  setup do
    @art = create(:art)
    @course = create(:course, art: @art)
  end

  test "visiting the index" do
    visit art_courses_path(@art)

    assert_selector "h1", text: "Courses"
    assert_text @course.day
    assert_text @course.time.strftime("%I:%M %p")
    assert_link "Add"
    assert_link "Show this course"
  end

  test "creating a course" do
    visit art_courses_path(@art)

    within("#add-course") do
      click_on "Add"
    end

    assert_selector "h1", text: "New course"
    assert_text @art.name

    course_params = attributes_for(:course)

    select course_params[:day], from: "Day"
    fill_in "Time", with: course_params[:time]

    click_on "Create Course"

    assert_text course_params[:day]
    assert_text course_params[:time].strftime("%I:%M %p")
  end

  test "editing a course" do
    visit art_course_path(@art, @course)
    click_on "Edit this course"

    assert_selector "h1", text: "Editing course"

    course_params = attributes_for(:course)

    select course_params[:day], from: "Day"
    fill_in "Time", with: course_params[:time].strftime("%I:%M %p")

    click_on "Update Course"

    assert_text course_params[:day]
  end

  test "show page displays meetings count" do
    meeting = create(:meeting, course: @course)

    visit art_course_path(@art, @course)

    assert_selector "h3", text: "Meetings (1)"
    assert_text meeting.date.to_s
  end

  test "index page shows meetings link" do
    visit art_courses_path(@art)

    within("#courses") do
      assert_link "New", href: new_art_course_meeting_path(@art, @course)
    end
  end

  test "destroying a course" do
    visit art_course_path(@art, @course)

    accept_confirm do
      click_on "Destroy this course"
    end

    assert_current_path art_path(@art)
    assert_no_text @course.day
  end
end
