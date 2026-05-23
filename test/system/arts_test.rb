# test/system/arts_test.rb
require "application_system_test_case"

class ArtsTest < ApplicationSystemTestCase
  setup do
    @art = create(:art)
  end

  test "visiting the index" do
    visit arts_url

    assert_current_path arts_path
    assert_selector "h1", text: "Arts"
    assert_link "#{@art.name} (#{@art.abbrev})", href: art_path(@art)
    assert_link "Edit Art", href: edit_art_path(@art)
    assert_link "New art", href: new_art_path
  end

  test "creating an art" do
    visit new_art_url

    assert_current_path new_art_path
    assert_selector "h1", text: "New art"
    assert_link "Back to arts", href: arts_path

    art_params = attributes_for(:art)

    fill_in "Name", with: art_params[:name]
    fill_in "Abbrev", with: art_params[:abbrev]
    click_on "Create Art"

    # put these first so we wait for the page to load before finding the id
    assert_selector "h2", text: "#{art_params[:name]} (#{art_params[:abbrev]})"
    assert_selector "h3", text: "Courses (0)"
    assert_selector "h3", text: "Belts (0)"
    new_art_id = current_path.split("/").last.to_i
    new_art = Art.find(new_art_id)
    assert_current_path art_path(new_art)
    assert_link "Add", href: new_art_course_path(new_art)
    assert_link "Add", href: new_art_belt_path(new_art)
    assert_link "Edit", href: edit_art_path(new_art)
    assert_link "Back to arts", href: arts_path
  end

  test "editing an art" do
    visit edit_art_url(@art)

    assert_current_path edit_art_path(@art)
    assert_selector "h1", text: "Editing art"
    assert_link "Show this art", href: art_path(@art)
    assert_link "Back to arts", href: arts_path

    art_params = attributes_for(:art)

    fill_in "Name", with: art_params[:name]
    fill_in "Abbrev", with: art_params[:abbrev]
    click_on "Update Art"

    assert_current_path art_path(@art)
    assert_selector "h2", text: "#{art_params[:name]} (#{art_params[:abbrev]})"
    assert_link "Edit", href: edit_art_path(@art)
    assert_link "Back to arts", href: arts_path
  end

  test "show page renders art details" do
    visit art_url(@art)

    assert_current_path art_path(@art)
    assert_selector "h2", text: "#{@art.name} (#{@art.abbrev})"
    assert_selector "h3", text: "Courses (0)"
    assert_selector "h3", text: "Belts (0)"
    assert_link "Add", href: new_art_course_path(@art)
    assert_link "Add", href: new_art_belt_path(@art)
    assert_link "Edit", href: edit_art_path(@art)
    assert_link "Back to arts", href: arts_path
  end

  test "show page renders nested courses" do
    course = create(:course, art: @art)

    visit art_url(@art)

    assert_current_path art_path(@art)
    assert_selector "h3", text: "Courses (1)"
    assert_text course.day
    assert_text course.time.strftime("%I:%M %p")
    assert_link "Show", href: art_course_path(@art, course)
    assert_link "Edit", href: edit_art_course_path(@art, course)
  end

  test "show page renders nested belts" do
    belt = create(:belt, art: @art)

    visit art_url(@art)

    assert_current_path art_path(@art)
    assert_selector "h3", text: "Belts (1)"
    assert_link belt.level, href: art_belt_path(@art, belt)
    assert_text belt.rank.to_s
    assert_link "Show", href: art_belt_path(@art, belt)
    assert_link "Edit", href: edit_art_belt_path(@art, belt)
  end

  test "destroying an art" do
    visit art_url(@art)

    accept_confirm do
      click_on "Destroy this art"
    end

    assert_current_path arts_path
    assert_selector "h1", text: "Arts"
    assert_no_text "#{@art.name} (#{@art.abbrev})"
  end
end