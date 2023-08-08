require "application_system_test_case"

class BeltsTest < ApplicationSystemTestCase
  setup do
    @belt = belts(:one)
  end

  test "visiting the index" do
    visit belts_url
    assert_selector "h1", text: "Belts"
  end

  test "should create belt" do
    visit belts_url
    click_on "New belt"

    fill_in "Img", with: @belt.img
    fill_in "Level", with: @belt.level
    click_on "Create Belt"

    assert_text "Belt was successfully created"
    click_on "Back"
  end

  test "should update Belt" do
    visit belt_url(@belt)
    click_on "Edit this belt", match: :first

    fill_in "Img", with: @belt.img
    fill_in "Level", with: @belt.level
    click_on "Update Belt"

    assert_text "Belt was successfully updated"
    click_on "Back"
  end

  test "should destroy Belt" do
    visit belt_url(@belt)
    click_on "Destroy this belt", match: :first

    assert_text "Belt was successfully destroyed"
  end
end
