require "test_helper"

class MeetingTest < ActiveSupport::TestCase
  def setup
    @meeting = build(:meeting)
  end

  test "valid meeting" do
    assert @meeting.valid?
  end

  test "requires course" do
    @meeting.course = nil
    assert_not @meeting.valid?
  end
end
