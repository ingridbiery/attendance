class Course < ApplicationRecord
  belongs_to :art
  has_many :meetings, -> { order(date: :desc) }, dependent: :destroy

  enum :day, { monday: 0, tuesday: 1, wednesday: 2, thursday: 3, friday: 4, saturday: 5, sunday: 6 }

  validates :day, presence: true

  def to_s
    "#{day.humanize} #{time&.strftime("%I:%M %p")}"
  end

end
