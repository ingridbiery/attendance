class Belt < ApplicationRecord
  belongs_to :art
  self.implicit_order_column = 'rank'

  validates :level, presence: true
  validates :img, presence: true
  validates :rank, presence: true
end
