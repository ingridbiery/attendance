class Belt < ApplicationRecord
  belongs_to :art
  self.implicit_order_column = 'rank'
  has_many :ranks, dependent: :destroy
  has_many :person, through: :ranks

  validates :level, presence: true
  validates :rank, presence: true
end
