# test/system/people_test.rb
require "application_system_test_case"

class PeopleTest < ApplicationSystemTestCase
  setup do
    @family = create(:family)
    @art = create(:art)
    @belt = create(:belt, art: @art)
    @person = create(:person, family: @family)
    create(:rank, person: @person, belt: @belt)
  end

  test "visiting the people index" do
    visit people_url

    assert_current_path people_path
    assert_selector "h1", text: "#{@art.abbrev} People"
    assert_text @person.first_name
    assert_text @person.last_name
    assert_text @person.family.name
    assert_text @person.dob.to_s
    assert_link "Show", href: family_person_path(@family, @person)
    assert_link "Edit", href: edit_family_person_path(@family, @person)
  end

  test "creating a person" do
    visit new_family_person_url(@family)

    assert_current_path new_family_person_path(@family)
    assert_selector "h1", text: "New person"
    assert_link "Back to family", href: family_path(@family)

    person_params = attributes_for(:person)

    fill_in "First name", with: person_params[:first_name]
    fill_in "Last name", with: person_params[:last_name]
    find("#person_dob").send_keys(person_params[:dob].strftime("%m%d%Y"))
    click_on "Create Person"

    # put these first so we wait for the page to load before finding the id
    assert_selector "h1", text: "#{person_params[:first_name]} #{person_params[:last_name]}"
    assert_text "DOB: #{person_params[:dob]}"
    new_person_id = current_path.split("/").last.to_i
    new_person = Person.find(new_person_id)
    assert_current_path family_person_path(@family, new_person_id)
    assert_link "Edit this person", href: edit_family_person_path(@family, new_person)
    assert_link "Back to family", href: family_path(@family)
  end

  test "editing a person" do
    visit edit_family_person_url(@family, @person)

    assert_current_path edit_family_person_path(@family, @person)
    assert_selector "h1", text: "Editing person"
    assert_link "Show this person", href: family_person_path(@family, @person)
    assert_link "Back to family", href: family_path(@family)

    person_params = attributes_for(:person)

    fill_in "First name", with: person_params[:first_name]
    fill_in "Last name", with: person_params[:last_name]
    find("#person_dob").send_keys(person_params[:dob].strftime("%m%d%Y"))
    click_on "Update Person"

    assert_current_path family_person_path(@family, @person)
    assert_selector "h1", text: "#{person_params[:first_name]} #{person_params[:last_name]}"
    assert_text "DOB: #{person_params[:dob]}"
    assert_link "Edit this person", href: edit_family_person_path(@family, @person)
    assert_link "Back to family", href: family_path(@family)
  end

  test "show page renders person details" do
    visit family_person_url(@family, @person)

    assert_current_path family_person_path(@family, @person)
    assert_selector "h1", text: @person.name
    assert_text "DOB: #{@person.dob}"
    assert_text "#{@art.abbrev} #{@belt.level}"
    assert_link "Edit this person", href: edit_family_person_path(@family, @person)
    assert_link "Back to family", href: family_path(@family)
  end

  test "show page renders multiple ranks" do
    art2 = create(:art)
    belt2 = create(:belt, art: art2)
    create(:rank, person: @person, belt: belt2)

    visit family_person_url(@family, @person)

    assert_current_path family_person_path(@family, @person)
    assert_text "#{@art.abbrev} #{@belt.level}"
    assert_text "#{art2.abbrev} #{belt2.level}"
  end

  test "destroying a person" do
    visit family_person_url(@family, @person)

    accept_confirm do
      click_on "Destroy this person"
    end

    assert_current_path family_path(@family)
    assert_selector "h3", text: "People in Family (0)"
    within("table") do
      assert_no_text @person.name
    end rescue assert_no_selector "table"
  end
end