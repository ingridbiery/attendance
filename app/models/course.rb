class Course < ApplicationRecord
  belongs_to :art
  has_many :meetings, dependent: :destroy

  validates :day, presence: true
end
