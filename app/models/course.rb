class Course < ApplicationRecord
  belongs_to :art
  has_many :meetings, dependent: :destroy

  enum :day, { monday: 0, tuesday: 1, wednesday: 2, thursday: 3, friday: 4, saturday: 5, sunday: 6 }

  validates :day, presence: true
end
