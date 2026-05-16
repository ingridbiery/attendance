require "test_helper"

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @family = create(:family)
    @person = create(:person, family: @family)
  end

  test "should get new" do
    get new_family_person_url(@family)
    assert_response :success
  end

  test "should create person" do
    person_params = attributes_for(:person, family: @family)

    assert_difference("Person.count") do
      post family_people_url(@family), params: {
        person: person_params
      }
    end

    assert_redirected_to family_person_url(@family, Person.order(:id).last)
  end

  test "should show person" do
    get family_person_url(@family, @person)
    assert_response :success
  end

  test "should get edit" do
    get edit_family_person_url(@family, @person)
    assert_response :success
  end

  test "should update person" do
    person_params = attributes_for(:person, family: @family)

    patch family_person_url(@family, @person), params: {
      person: person_params
    }

    assert_redirected_to family_person_url(@family, @person)
  end

  test "should destroy person" do
    assert_difference("Person.count", -1) do
      delete family_person_url(@family, @person)
    end

    assert_redirected_to family_url(@family)
  end
end