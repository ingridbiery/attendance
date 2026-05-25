class Meeting < ApplicationRecord
  belongs_to :course
  has_one :art, through: :course
  has_many :attendances, dependent: :destroy
  has_many :people, through: :attendances

  validates :date, presence: true

  self.implicit_order_column = 'date'
end
