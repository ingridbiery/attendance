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

  test "requires art" do
    @belt.art = nil
    assert_not @belt.valid?
  end

  test "destroy dependents" do
    create(:rank, belt: @belt)
    @belt.destroy
    assert_empty Rank.where(belt_id: @belt.id)
  end
end
