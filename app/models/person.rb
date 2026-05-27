class Person < ApplicationRecord
  belongs_to :family
  self.implicit_order_column = 'dob'
  has_many :ranks, dependent: :destroy
  has_many :belts, through: :ranks
  has_many :arts, through: :belts
  has_many :attendances, dependent: :destroy

  validates :first_name, presence: true,
                         length: { maximum: 30 }
  validates :last_name, presence: true,
                        length: { maximum: 30 }

  validate :unique_name_per_family

  # get the full name for this person
  def name
    "#{first_name} #{last_name}"
  end

  def belt_for(art)
    ranks.joins(:belt).where(belts: { art: art }).order("belts.level DESC").first&.belt
  end

  private
    def unique_name_per_family
      duplicate = Person.where("LOWER(first_name) = ? AND LOWER(last_name) = ? AND family_id = ?",
                               first_name.downcase, last_name.downcase, family_id)
      duplicate = duplicate.where.not(id: id) if persisted?
      errors.add(:base, "already has a person with this name") if duplicate.exists?
    end
end
