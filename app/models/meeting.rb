class Meeting < ApplicationRecord
  belongs_to :course
  has_one :art, through: :course

  self.implicit_order_column = 'date'
end
