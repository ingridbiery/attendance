require "test_helper"

class CourseTest < ActiveSupport::TestCase
  def setup
    @course = build(:course)
  end

  test "valid course" do
    assert @course.valid?
  end

  test "requires art" do
    @course.art = nil
    assert_not @course.valid?
  end

  test "destroy dependents" do
    create(:meeting, course: @course)
    @course.destroy
    assert_empty Meeting.where(course_id: @course.id)
  end
end
