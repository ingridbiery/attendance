class Art < ApplicationRecord
  has_many :belts, dependent: :destroy
  has_many :people, -> {order('belts.level DESC, last_name, first_name')}, through: :belts
  has_many :courses, dependent: :destroy
  has_many :meetings, through: :courses

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { maximum: 50 }
  validates :abbrev, presence: true,
                     length: { maximum: 5 }
end
