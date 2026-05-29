require 'faker'

# ============================================================
# Clean slate
# ============================================================
Attendance.destroy_all
Meeting.destroy_all
Course.destroy_all
Rank.destroy_all
Belt.destroy_all
Art.destroy_all
Family.destroy_all
Person.destroy_all

# ============================================================
# Arts + Belts (real data)
# ============================================================

BELT_PROGRESSION = [
  { name: "8th Gup",  color: "white",  level: -8 },
  { name: "7th Gup",  color: "yellow", level: -7 },
  { name: "6th Gup",  color: "orange", level: -6 },
  { name: "5th Gup",  color: "green",  level: -5 },
  { name: "4th Gup",  color: "blue",   level: -4 },
  { name: "3rd Gup",  color: "purple", level: -3 },
  { name: "2nd Gup",  color: "brown",  level: -2 },
  { name: "1st Gup",  color: "red",    level: -1 },
  { name: "Deputy Black Belt", color: "red",   level: 0 },
  { name: "1st Dan",  color: "black",  level: 1 },
  { name: "2nd Dan",  color: "black",  level: 2 },
  { name: "3rd Dan",  color: "black",  level: 3 },
  { name: "4th Dan",  color: "black",  level: 4 },
  { name: "5th Dan",  color: "black",  level: 5 }
]

ART_DEFS = [
  ["Taekwondo",         "TKD"],
  ["Haidong Gumdo",     "HDG"],
  ["Hapkido",           "HKD"],
  ["Gongkwon Yusul",    "GKY"],
  ["Archery/Weapons",   "A/W"],
  ["KickBoxing",        "KB"]
]

arts = ART_DEFS.map do |name, abbrev|
  art = Art.create!(name: name, abbrev: abbrev)
  BELT_PROGRESSION.each { |b| art.belts.create!(b) }
  art
end

# ============================================================
# Courses (1–5 per art)
# ============================================================

arts.each do |art|
  rand(1..5).times do
    art.courses.create!(
      day: Course.days.keys.sample  # uses your enum
    )
  end
end

# ============================================================
# Families + People + Ranks
# ============================================================

100.times do
  last = Faker::Name.last_name
  family = Family.create!(name: last)

  rand(1..4).times do
    person = family.people.create!(
      first_name: Faker::Name.first_name,
      last_name:  last,
      dob:        Faker::Date.birthday(min_age: 5, max_age: 60)
    )

    # Person trains in 1–3 random arts
    arts.sample(rand(1..3)).each do |art|
      Rank.create!(
        person: person,
        belt: art.belts.sample
      )
    end
  end
end

# ============================================================
# Meetings (5–10 per course)
# Attendance only from people with belts in that art
# ============================================================

Course.find_each do |course|
  rand(5..10).times do
    # pick a random week in the past 120 days
    base = Faker::Date.backward(days: 120)

    # shift to the correct weekday
    target_wday = Course.days[course.day]   # enum → integer 0–6
    delta = target_wday - base.wday
    date = base + delta

    meeting = course.meetings.create!(
      art: course.art,
      date: date
    )

    eligible = Person.joins(:belts)
                     .where(belts: { art_id: meeting.art_id })
                     .distinct

    eligible.sample(rand(3..12)).each do |person|
      Attendance.create!(meeting: meeting, person: person)
    end
  end
end

# ============================================================
# Summary
# ============================================================

puts "Seeded:"
puts "  #{Art.count} arts"
puts "  #{Belt.count} belts"
puts "  #{Course.count} courses"
puts "  #{Family.count} families"
puts "  #{Person.count} people"
puts "  #{Rank.count} ranks"
puts "  #{Meeting.count} meetings"
puts "  #{Attendance.count} attendances"
