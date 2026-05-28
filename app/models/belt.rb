class Belt < ApplicationRecord
  belongs_to :art
  self.implicit_order_column = 'level'
  has_many :ranks, dependent: :destroy
  has_many :people, through: :ranks

  validates :name, presence: true,
                   length: { maximum: 50 }
  validates :level, presence: true
  
  validate :image_if_given_exists

  private
    def image_if_given_exists
      return if img.blank?  # blank is allowed

      path = Rails.root.join("app/assets/images", img)

      unless File.exist?(path)
        errors.add(:img, "does not exist in app/assets/images")
      end
    end
end
