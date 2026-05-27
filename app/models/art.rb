class Art < ApplicationRecord
  has_many :belts, dependent: :destroy
  has_many :people, -> {order('belts.level DESC, last_name, first_name')}, through: :belts
  has_many :courses, dependent: :destroy
  has_many :meetings, through: :courses
  has_many :enrollments, dependent: :destroy
  has_many :enrolled_people, through: :enrollments, source: :person
  has_many :payments, dependent: :destroy

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { maximum: 50 }
  validates :abbrev, presence: true,
                     length: { maximum: 5 }
end
