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

  test "name max length" do
    @belt.name = "a" * 51
    assert_not @belt.valid?
  end

  test "requires level" do
    @belt.level = nil
    assert_not @belt.valid?
  end

  test "blank image allowed" do
    @belt.img = ""
    assert @belt.valid?
  end

  test "existing image allowed" do
    @belt.img = "test.png"
    assert @belt.valid?
  end

  test "non-existent image not allowed" do
    @belt.img = "missing.png"
    assert_not @belt.valid?
  end

  test "requires art" do
    @belt.art = nil
    assert_not @belt.valid?
  end

  test "destroy dependents" do
    @belt.save

    rank = create(:rank, belt: @belt)

    @belt.destroy

    assert_not rank.exists?(rank.id)
  end
end
