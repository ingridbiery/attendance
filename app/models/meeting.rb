class Meeting < ApplicationRecord
  belongs_to :course
  has_one :art, through: :course
  has_many :attendances, dependent: :destroy

  self.implicit_order_column = 'date'
end
