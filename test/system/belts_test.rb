# test/system/belts_test.rb
require "application_system_test_case"

class BeltsTest < ApplicationSystemTestCase
  setup do
    @art = create(:art)
    @belt = create(:belt, art: @art)
  end

  test "creating a belt" do
    visit new_art_belt_url(@art)

    assert_current_path new_art_belt_path(@art)
    assert_selector "h1", text: "New belt"
    assert_link "Back to art", href: art_path(@art)

    belt_params = attributes_for(:belt)

    fill_in "Name", with: belt_params[:name]
    fill_in "Level", with: belt_params[:level]
    fill_in "Img", with: ""
    click_on "Create Belt"

    # put these first so we wait for the page to load before finding the id
    assert_text belt_params[:level].to_s
    new_belt_id = current_path.split("/").last.to_i
    new_belt = Belt.find(new_belt_id)
    assert_current_path art_belt_path(@art, new_belt)
    assert_link belt_params[:name], href: art_belt_path(@art, new_belt)
    assert_link "Edit this belt", href: edit_art_belt_path(@art, new_belt)
    assert_link "Back to art", href: art_path(@art)
  end

  test "editing a belt" do
    visit edit_art_belt_url(@art, @belt)

    assert_current_path edit_art_belt_path(@art, @belt)
    assert_selector "h1", text: "Editing belt"
    assert_link "Show this belt", href: art_belt_path(@art, @belt)
    assert_link "Back to art", href: art_path(@art)

    belt_params = attributes_for(:belt)

    fill_in "Name", with: belt_params[:name]
    fill_in "Level", with: belt_params[:level]
    fill_in "Img", with: ""
    click_on "Update Belt"

    # put these first so we wait for the page to load before finding the id
    assert_link belt_params[:name], href: art_belt_path(@art, @belt)
    assert_text belt_params[:level].to_s
    assert_current_path art_belt_path(@art, @belt)
    assert_link "Edit this belt", href: edit_art_belt_path(@art, @belt)
    assert_link "Back to art", href: art_path(@art)
  end

  test "show page renders belt details" do
    visit art_belt_url(@art, @belt)

    # put these first so we wait for the page to load before finding the id
    assert_link @belt.name, href: art_belt_path(@art, @belt)
    assert_text @belt.level.to_s
    assert_current_path art_belt_path(@art, @belt)
    assert_link "Edit this belt", href: edit_art_belt_path(@art, @belt)
    assert_link "Back to art", href: art_path(@art)
  end

  test "destroying a belt" do
    visit art_belt_url(@art, @belt)

    accept_confirm do
      click_on "Destroy this belt"
    end

    # put these first so we wait for the page to load before finding the id
    assert_text "#{@belt.name} was successfully destroyed"
    assert_current_path art_path(@art)
    assert_selector "h3", text: "Belts (0)"
  end
end