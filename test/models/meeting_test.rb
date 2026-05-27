require "test_helper"

class MeetingTest < ActiveSupport::TestCase
  def setup
    @meeting = build(:meeting)
  end

  test "valid meeting" do
    assert @meeting.valid?
  end

  test "date must be unique per course" do
    meeting = create(:meeting)
    dup = build(:meeting, course: meeting.course, date: meeting.date)
    assert_not dup.valid?
  end

  test "same date different course is valid" do
    meeting = create(:meeting)
    course = create(:course)
    dup = build(:meeting, course: course, date: meeting.date)
    assert dup.valid?
  end

  test "destroy dependents" do
    create(:attendance, meeting: @meeting)
    @meeting.destroy
    assert_empty Attendance.where(meeting_id: @meeting.id)
  end
end
