# test/models/payment_test.rb
require "test_helper"

class PaymentTest < ActiveSupport::TestCase
  def setup
    @payment = build(:payment)
  end

  test "valid payment" do
    assert @payment.valid?
  end

  test "requires family" do
    @payment.family = nil
    assert_not @payment.valid?
  end

  test "requires art" do
    @payment.art = nil
    assert_not @payment.valid?
  end

  test "requires plan_type" do
    @payment.plan_type = nil
    assert_not @payment.valid?
  end

  test "requires paid_until" do
    @payment.paid_until = nil
    assert_not @payment.valid?
  end

  test "family can only have one payment per art" do
    existing = create(:payment)
    duplicate = build(:payment, family: existing.family, art: existing.art)
    assert_not duplicate.valid?
  end

  test "family can have payments for multiple arts" do
    payment = create(:payment)
    other_art = create(:art, name: "Other Art", abbrev: "OA")
    second_payment = build(:payment, family: payment.family, art: other_art)
    assert second_payment.valid?
  end

  test "paid? returns true when paid_until is in the future" do
    @payment.paid_until = Date.today + 1
    assert @payment.paid?
  end

  test "paid? returns false when paid_until is in the past" do
    @payment.paid_until = Date.today - 1
    assert_not @payment.paid?
  end

  test "valid plan types are accepted" do
    Payment.plan_types.keys.each do |plan|
      @payment.plan_type = plan
      assert @payment.valid?, "Expected #{plan} to be valid"
    end
  end

  test "once? returns true for once plans" do
    @payment.plan_type = :one_person_once
    assert @payment.once?
    @payment.plan_type = :family_once
    assert @payment.once?
  end

  test "once? returns false for unlimited plans" do
    @payment.plan_type = :one_person_unlimited
    assert_not @payment.once?
    @payment.plan_type = :family_unlimited
    assert_not @payment.once?
  end

  test "family_plan? returns true for family plans" do
    @payment.plan_type = :family_once
    assert @payment.family_plan?
    @payment.plan_type = :family_unlimited
    assert @payment.family_plan?
  end

  test "family_plan? returns false for one person plans" do
    @payment.plan_type = :one_person_once
    assert_not @payment.family_plan?
    @payment.plan_type = :one_person_unlimited
    assert_not @payment.family_plan?
  end
end