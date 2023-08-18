class Art < ApplicationRecord
  has_many :belts, dependent: :destroy
  has_many :people, -> {order('belts.rank DESC, last_name, first_name')}, through: :belts

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { maximum: 50 }
  validates :abbrev, presence: true
end
