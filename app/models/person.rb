class Person < ApplicationRecord
  belongs_to :family
  self.implicit_order_column = 'dob'
  has_many :ranks, dependent: :destroy
  has_many :belts, through: :ranks
  has_many :arts, through: :belts

  validates :first_name, presence: true,
                         length: { maximum: 30 }
  validates :last_name, presence: true,
                        length: { maximum: 30 }

  validates_uniqueness_of :first_name,
                          scope: :last_name,
                          message: "with same last name is already in the system."

  # get the full name for this person
  def name
    "#{first_name} #{last_name}"
  end
end
