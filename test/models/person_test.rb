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

  test "name must be unique per family" do
    person = create(:person, first_name: @person.first_name.upcase)
    dup = build(:person, first_name: person.first_name.downcase, last_name: person.last_name,
                 family: person.family)
    assert_not dup.valid?
  end

  test "same name different family is valid" do
    person = create(:person)
    family = create(:family)
    dup = build(:person, family: family, first_name: person.first_name,
                last_name: person.last_name)
    assert dup.valid?
  end

  test "destroy dependents" do
    @person.save
    
    rank = create(:rank, person: person)
    attendance = create(:attendance, person: person)
    enrollment = create(:enrollment, person: person)

    person.destroy

    assert_not Rank.exists?(rank.id)
    assert_not Attendance.exists?(attendance.id)
    assert_not Enrollment.exists?(enrollment.id)
  end
end
