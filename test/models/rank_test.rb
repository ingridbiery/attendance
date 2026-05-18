require "test_helper"

class RankTest < ActiveSupport::TestCase
  def setup
    @rank = build(:rank)
  end

  test "valid rank" do
    assert @rank.valid?
  end

  test "requires belt" do
    @rank.belt = nil
    assert_not @rank.valid?
  end

  test "requires person" do
    @rank.person = nil
    assert_not @rank.valid?
  end
end
