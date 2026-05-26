# test/system/families_test.rb
require "application_system_test_case"

class FamiliesTest < ApplicationSystemTestCase
  setup do
    @family = create(:family)
  end

  test "visiting the index" do
    visit families_url

    assert_current_path families_path
    assert_selector "h1", text: "Families"
    assert_link @family.name, href: family_path(@family)
    assert_link "Edit", href: edit_family_path(@family)
    assert_link "New family", href: new_family_path
  end

  test "creating a family" do
    visit new_family_url

    assert_current_path new_family_path
    assert_selector "h1", text: "New family"

    name = "Family Name"

    fill_in "Name", with: name
    click_on "Create Family"

    # put these first so we wait for the page to load before finding the id
    assert_selector "h2", text: "The #{name} Family"
    assert_selector "h3", text: "People in Family (0)"
    new_family_id = current_path.split("/").last.to_i
    new_family = Family.find(new_family_id)
    assert_current_path family_path(new_family)
    assert_link "Add", href: new_family_person_path(new_family)
    assert_link "Edit", href: edit_family_path(new_family)
    assert_link "Back to families", href: families_path
  end

  test "editing a family" do
    visit edit_family_url(@family)

    assert_current_path edit_family_path(@family)
    assert_selector "h1", text: "Editing family"

    name = "New Name"

    fill_in "Name", with: name
    click_on "Update Family"

    assert_current_path family_path(@family)
    assert_selector "h2", text: "The #{name} Family"
    assert_link "Edit", href: edit_family_path(@family)
    assert_link "Back to families", href: families_path
  end

  test "show page renders family details" do
    visit family_url(@family)

    assert_current_path family_path(@family)
    assert_selector "h2", text: "The #{@family.name} Family"
    assert_selector "h3", text: "People in Family (0)"
    assert_link "Add", href: new_family_person_path(@family)
    assert_link "Edit", href: edit_family_path(@family)
    assert_link "Back to families", href: families_path
  end

  test "show page renders people" do
    person = create(:person, family: @family)

    visit family_url(@family)

    assert_current_path family_path(@family)
    assert_selector "h3", text: "People in Family (1)"
    assert_link person.name, href: family_person_path(@family, person)
    assert_text person.dob.to_s
    assert_link "Show", href: family_person_path(@family, person)
    assert_link "Edit", href: edit_family_person_path(@family, person)
  end

  test "destroying a family" do
    visit family_url(@family)

    accept_confirm do
      click_on "Destroy this family"
    end

    assert_current_path families_path
    assert_selector "h1", text: "Families"
    within("table") do
      assert_no_text @family.name
    end
  end
end