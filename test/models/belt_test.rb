require "test_helper"

class BeltTest < ActiveSupport::TestCase
  def setup
    @belt = build(:belt)
  end

  test "valid belt" do
    assert @belt.valid?
  end

  test "requires name" do
    @belt.name = ""
    assert_not @belt.valid?
  end

  test "requires level" do
    @belt.level = nil
    assert_not @belt.valid?
  end

  test "requires art" do
    @belt.art = nil
    assert_not @belt.valid?
  end

  test "dependent destroy ranks" do
    belt = create(:belt)
    rank = create(:rank, belt: belt)

    assert_difference("Rank.count", -1) do
      belt.destroy
    end
  end
end
