class Meeting < ApplicationRecord
  belongs_to :course
  has_one :art, through: :course
  has_many :attendances, dependent: :destroy
  has_many :people, through: :attendances

  validates :date, uniqueness: { scope: :course_id, message: "already has a meeting on this date" }
  validates :date, presence: true

  self.implicit_order_column = { date: :desc }
end
