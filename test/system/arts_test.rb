require "application_system_test_case"

class ArtsTest < ApplicationSystemTestCase
  setup do
    @art = create(:art)
  end

  test "visiting the index" do
    visit arts_url

    assert_selector "h1", text: "Arts"
    assert_text "#{@art.name} (#{@art.abbrev})"
    assert_link "Edit Art"
    assert_link "New art"
  end

  test "creating an art" do
    visit arts_url
    click_on "New art"

    art_params = attributes_for(:art)

    fill_in "Name", with: art_params[:name]
    fill_in "Abbrev", with: art_params[:abbrev]
    click_on "Create Art"

    # Your index page shows: "#{name} (#{abbrev})"
    assert_text "#{art_params[:name]} (#{art_params[:abbrev]})"
    assert_link "Back to arts"
  end

  test "updating an art" do
    visit art_url(@art)

    click_on "Edit", match: :first

    art_params = attributes_for(:art)

    fill_in "Name", with: art_params[:name]
    fill_in "Abbrev", with: art_params[:abbrev]
    click_on "Update Art"

    assert_text "#{art_params[:name]} (#{art_params[:abbrev]})"
    assert_link "Back to arts"
  end

  test "destroying an art" do
    visit art_url(@art)

    # Your show page uses button_to "Destroy this art"
    accept_confirm do
      click_on "Destroy this art"
    end

    assert_selector "h1", text: "Arts"
    assert_no_text "#{@art.name} (#{@art.abbrev})"
  end

  test "show page renders nested belts and courses sections" do
    course = create(:course, art: @art)
    belt   = create(:belt, art: @art)

    visit art_url(@art)

    # From _art.html.erb
    assert_text "Courses (#{@art.courses.count})"
    assert_text "Belts (#{@art.belts.count})"

    # Ensure nested tables render
    assert_text course.day if course.day.present?
    assert_text belt.level if belt.level.present?
  end
end
