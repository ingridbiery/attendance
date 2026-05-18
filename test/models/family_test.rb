require "test_helper"

class FamilyTest < ActiveSupport::TestCase
  test "valid family" do
    family = build(:family)
    assert family.valid?
  end
end
