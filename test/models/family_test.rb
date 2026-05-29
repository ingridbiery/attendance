require "test_helper"

class FamilyTest < ActiveSupport::TestCase
  def setup
    @family = build(:family)
  end

  test "valid family" do
    assert @family.valid?
  end

  test "requires name" do
    @family.name = ""
    assert_not @family.valid?
  end

  test "name unique case insensitive" do
    family = create(:family, name: @family.name.upcase)
    dup = build(:family, name: @family.name.downcase)
    assert_not dup.valid?
  end

  test "name max length" do
    @family.name = "a" * 51
    assert_not @family.valid?
  end

  ["Smith", "Garcia/Lopez", "O'Brien", "O\u2019Brian", "van der Berg", 
   "García", "Müller", "Ñoño", "山田"].each do |name|
    test "#{name} is a valid family name" do
      @family.name = name
      assert @family.valid?
    end
  end

  # invalid
  ["Smith<script>", "foo@bar", "hello!", "Smith#1"].each do |name|
    test "#{name} is an invalid family name" do
      @family.name = name
      assert_not @family.valid?
    end
  end

  test "destroy dependents" do
    @family.save
    create(:person, family: @family)
    @family.destroy
    assert_empty Person.where(family_id: @family.id)
  end
end
