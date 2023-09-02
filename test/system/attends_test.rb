require "application_system_test_case"

class AttendsTest < ApplicationSystemTestCase
  setup do
    @attend = attends(:one)
  end

  test "visiting the index" do
    visit attends_url
    assert_selector "h1", text: "Attends"
  end

  test "should create attend" do
    visit attends_url
    click_on "New attend"

    fill_in "Meeting", with: @attend.meeting_id
    fill_in "Person", with: @attend.person_id
    click_on "Create Attend"

    assert_text "Attend was successfully created"
    click_on "Back"
  end

  test "should update Attend" do
    visit attend_url(@attend)
    click_on "Edit this attend", match: :first

    fill_in "Meeting", with: @attend.meeting_id
    fill_in "Person", with: @attend.person_id
    click_on "Update Attend"

    assert_text "Attend was successfully updated"
    click_on "Back"
  end

  test "should destroy Attend" do
    visit attend_url(@attend)
    click_on "Destroy this attend", match: :first

    assert_text "Attend was successfully destroyed"
  end
end
