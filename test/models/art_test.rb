require "test_helper"

class ArtTest < ActiveSupport::TestCase
  def setup
    @art = build(:art)
  end

  test "valid art" do
    assert @art.valid?
  end

  test "requires name" do
    @art.name = ""
    assert_not @art.valid?
  end

  test "requires abbrev" do
    @art.abbrev = ""
    assert_not @art.valid?
  end

  test "name max length" do
    @art.name = "a" * 51
    assert_not @art.valid?
  end

  test "abbrev max length" do
    @art.abbrev = "a" * 6
    assert_not @art.valid?
  end

  test "name unique case insensitive" do
    create(:art, name: "Karate")
    dup = build(:art, name: "karate")
    assert_not dup.valid?
  end

  test "destroy dependents" do
    create(:belt, art: @art)
    @art.destroy
    assert_empty Belt.where(art_id: @art.id)
  end
end
