require "test_helper"

class PersonTest < ActiveSupport::TestCase
  def setup
    @person = build(:person)
  end

  test "valid person" do
    assert @person.valid?
  end

  test "requires first_name" do
    @person.first_name = ""
    assert_not @person.valid?
  end

  test "requires last_name" do
    @person.last_name = ""
    assert_not @person.valid?
  end

  test "requires family" do
    @person.family = nil
    assert_not @person.valid?
  end

  test "unique first_name scoped to last_name" do
    create(:person, first_name: "Ingrid", last_name: "Biery")
    dup = build(:person, first_name: "Ingrid", last_name: "Biery")
    assert_not dup.valid?
  end
end
