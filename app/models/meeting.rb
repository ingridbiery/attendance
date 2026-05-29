class Meeting < ApplicationRecord
  belongs_to :course
  has_one :art, through: :course
  has_many :attendances, dependent: :destroy
  has_many :people, through: :attendances

  validates :date, uniqueness: { scope: :course_id, message: "already has a meeting on this date" }
  validates :date, presence: true

  self.implicit_order_column = { date: :desc }

  # people sorted by belt level in this art (can't do this for the people automatically because
  # that would require a join, and that makes duplicates. SQL won't dedupe without changing the sort)
  def sorted_people
    people.sort_by do |p|
      level = p.belts.where(art_id: art.id).maximum(:level) [-level, p.last_name, p.first_name]
    end
  end

  # people who are already signed up or people who will be signed up once the meeting is saved
  def selected_people(people_ids = nil)
    if persisted?
      sorted_people
    else 
      ids = Array(people_ids).map(&:to_i)
      art.people.select { |p| ids.include?(p.id) }
    end
  end

  def attended_previous
    return [] unless previous
    previous.selected_people
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
