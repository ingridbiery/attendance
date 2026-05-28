class Meeting < ApplicationRecord
  belongs_to :course
  has_one :art, through: :course
  has_many :attendances, dependent: :destroy
  has_many :people, through: :attendances

  validates :date, uniqueness: { scope: :course_id, message: "already has a meeting on this date" }
  validates :date, presence: true

  self.implicit_order_column = { date: :desc }

  # return the list of people who have attended this class if it's been saved
  # return the people associated with the passed in ids if it has not been saved
  def attended(people_ids = nil)
    if persisted?
      people
    else 
      ids = Array(people_ids).map(&:to_i)
      art.people.select { |p| ids.include?(p.id) }
    end
  end

  def attended_previous
    return [] unless previous
    previous.attended
  end

  # return the meeting immediately before this one
  def previous
    course.meetings.where("date < ?", date).order(:date).last
  end

  # return all people eligible to attend this meeting
  def eligible_people
    art.people
  end
end
