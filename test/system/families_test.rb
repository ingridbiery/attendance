require "application_system_test_case"

class FamiliesTest < ApplicationSystemTestCase
  setup do
    @family = create(:family)
  end

  test "visiting the index" do
    visit families_url

    assert_selector "h1", text: "Families"
    assert_text @family.name
    assert_link "Edit"
    assert_link "New family"
  end

  test "creating a family" do
    visit families_url
    click_on "New family"

    assert_selector "h1", text: "New family"

    family_params = attributes_for(:family)
    fill_in "Name", with: family_params[:name]
    click_on "Create Family"

    assert_text family_params[:name]
  end

  test "editing a family" do
    visit families_url
    click_on "Edit", match: :first

    assert_selector "h1", text: "Editing family"

    family_params = attributes_for(:family)
    fill_in "Name", with: family_params[:name]
    click_on "Update Family"

    assert_text family_params[:name]
  end

  test "destroying a family" do
    visit family_url(@family)

    accept_confirm do
      click_on "Destroy this family"
    end

    assert_current_path families_path
    within("table") do
      assert_no_text @family.name
    end
  end

  test "show page renders family details" do
    visit family_url(@family)

    assert_text @family.name
    assert_link "Edit"
    assert_link "Back to families"
  end
end