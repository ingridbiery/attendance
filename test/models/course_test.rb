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
    @course.save

    meeting = create(:meeting, course: @course)

    @course.destroy

    assert_not meeting.exists?(meeting.id)
  end
end
