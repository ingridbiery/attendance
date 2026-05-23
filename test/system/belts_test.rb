require "application_system_test_case"

class BeltsTest < ApplicationSystemTestCase
  setup do
    @art = create(:art)
    @belt = create(:belt, art: @art)
  end

  test "creating a belt" do
    visit art_url(@art)

    # The "Add" link next to Belts
    within("h3", text: "Belts") do
      click_on "Add"
    end
    
    belt_params = attributes_for(:belt)

    fill_in "Level", with: belt_params[:level]
    fill_in "Img", with: belt_params[:img]
    fill_in "Rank", with: belt_params[:rank]
    click_on "Create Belt"

    assert_text belt_params[:level]
    assert_text belt_params[:rank]
    assert_link "Back to art"
  end

  test "showing a belt" do
    visit art_url(@art)

    click_on @belt.level

    assert_text @belt.level
    assert_text @belt.rank
    assert_link "Edit this belt"
    assert_link "Back to art"
  end

  test "updating a belt" do
    visit art_belt_url(@art, @belt)

    click_on "Edit this belt"

    belt_params = attributes_for(:belt)

    fill_in "Level", with: belt_params[:level]
    fill_in "Img", with: belt_params[:img]
    fill_in "Rank", with: belt_params[:rank]
    click_on "Update Belt"

    assert_text belt_params[:level]
    assert_text belt_params[:rank]
  end

  test "destroying a belt" do
    visit art_belt_url(@art, @belt)

    accept_confirm do
      click_on "Destroy this belt"
    end

    # After destroy, user returns to the Art show page
    assert_current_path art_path(@art)
    assert_no_selector "#belt-#{@belt.id}"
  end
end
