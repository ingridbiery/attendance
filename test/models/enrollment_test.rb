# test/models/enrollment_test.rb
require "test_helper"

class EnrollmentTest < ActiveSupport::TestCase
  def setup
    @enrollment = build(:enrollment)
  end

  test "valid enrollment" do
    assert @enrollment.valid?
  end

  test "requires person" do
    @enrollment.person = nil
    assert_not @enrollment.valid?
  end

  test "requires art" do
    @enrollment.art = nil
    assert_not @enrollment.valid?
  end

  test "person can only be enrolled in an art once" do
    existing = create(:enrollment)
    duplicate = build(:enrollment, person: existing.person, art: existing.art)
    assert_not duplicate.valid?
  end

  test "person can be enrolled in multiple arts" do
    enrollment = create(:enrollment)
    other_art = create(:art, name: "Other Art", abbrev: "OA")
    second_enrollment = build(:enrollment, person: enrollment.person, art: other_art)
    assert second_enrollment.valid?
  end

  test "multiple people can be enrolled in the same art" do
    enrollment = create(:enrollment)
    second_enrollment = build(:enrollment, art: enrollment.art)
    assert second_enrollment.valid?
  end
end