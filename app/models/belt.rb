class Belt < ApplicationRecord
  belongs_to :art
  self.implicit_order_column = 'level'
  has_many :ranks, dependent: :destroy
  has_many :people, through: :ranks

  validates :name, presence: true,
                   length: { maximum: 50 }
  validates :level, presence: true
end
