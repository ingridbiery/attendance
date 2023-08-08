class Art < ApplicationRecord
  has_many :belts, dependent: :destroy

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { maximum: 50 }
  validates :abbrev, presence: true
end
