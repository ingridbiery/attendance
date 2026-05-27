class Payment < ApplicationRecord
  belongs_to :family
  belongs_to :art
  belongs_to :person, optional: true

  enum :plan_type, {
    one_person_once: 0,
    one_person_unlimited: 1,
    family_once: 2,
    family_unlimited: 3
  }

  validates :plan_type, presence: true
  validates :paid_until, presence: true
  validates :family_id, uniqueness: { scope: :art_id }

  def paid?
    paid_until >= Date.today
  end

  def once?
    one_person_once? || family_once?
  end

  def family_plan?
    family_once? || family_unlimited?
  end
end