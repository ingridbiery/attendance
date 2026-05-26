# db/seeds.rb
require 'faker'

# ============================================================
# Clean slate
# ============================================================
Rank.destroy_all
Attendance.destroy_all
Meeting.destroy_all
Course.destroy_all
Belt.destroy_all
Art.destroy_all
Family.destroy_all

# ============================================================
# Arts, Belts, Courses  (real data)
# ============================================================

BELT_PROGRESSION = [
{ name: "8th Gup", img: "",  color: "white",  level: -8 },
{ name: "7th Gup", img: "", color: "yellow", level: -7 },
{ name: "6th Gup", img: "", color: "orange", level: -6 },
{ name: "5th Gup", img: "",  color: "green",  level: -5 },
{ name: "4th Gup", img: "",   color: "blue",   level: -4 },
{ name: "3rd Gup", img: "", color: "purple", level: -3 },
{ name: "2nd Gup", img: "",  color: "brown",  level: -2 },
{ name: "1st Gup", img: "",    color: "red",    level: -1 },
{ name: "Deputy Black Belt", img: "", color: "red", level: 0 },
{ name: "1st Dan", img: "",  color: "black",  level: 1 },
{ name: "2nd Dan", img: "",  color: "black",  level: 2 },
{ name: "3rd Dan", img: "",  color: "black",  level: 3 },
{ name: "4th Dan", img: "",  color: "black",  level: 4 },
{ name: "5th Dan", img: "",  color: "black",  level: 5 },
]

tkd = Art.create!(name: "Taekwondo", abbrev: "TKD")
BELT_PROGRESSION.each { |b| tkd.belts.create!(b) }
tkd.courses.create!(day: :sunday)
tkd.courses.create!(day: :tuesday)
tkd.courses.create!(day: :wednesday)
tkd.courses.create!(day: :thursday)

hdg = Art.create!(name: "Haidong Gumdo", abbrev: "HDG")
BELT_PROGRESSION.each { |b| hdg.belts.create!(b) }
hdg.courses.create!(day: :sunday)
hdg.courses.create!(day: :monday)
hdg.courses.create!(day: :tuesday)
hdg.courses.create!(day: :wednesday)
hdg.courses.create!(day: :thursday)
hdg.courses.create!(day: :friday)

hkd = Art.create!(name: "Hapkido", abbrev: "HKD")
BELT_PROGRESSION.each { |b| hkd.belts.create!(b) }
hkd.courses.create!(day: :monday)
hkd.courses.create!(day: :wednesday)
hkd.courses.create!(day: :friday)

gky = Art.create!(name: "Gongkwon Yusul", abbrev: "GKY")
BELT_PROGRESSION.each { |b| gky.belts.create!(b) }
gky.courses.create!(day: :sunday)
gky.courses.create!(day: :monday)
gky.courses.create!(day: :wednesday)
gky.courses.create!(day: :friday)

a_w = Art.create!(name: "Archery/Weapons", abbrev: "A/W")
BELT_PROGRESSION.each { |b| a_w.belts.create!(b) }
a_w.courses.create!(day: :sunday)
a_w.courses.create!(day: :friday)

kb = Art.create!(name: "KickBoxing", abbrev: "KB")
BELT_PROGRESSION.each { |b| kb.belts.create!(b) }
kb.courses.create!(day: :wednesday)

all_arts = Art.all.to_a

# ============================================================
# Families, People, Ranks  (Faker-generated)
# ============================================================

last_names = 100.times.map { Faker::Name.last_name }.uniq
last_names.each do |last_name|
  family = Family.find_or_create_by!(name: last_name)
  
  rand(1..4).times do
    person = family.people.create!(
    first_name: Faker::Name.first_name,
    last_name:  last_name,
    dob:        Faker::Date.birthday(min_age: 5, max_age: 60)
    )
    
    # Each person gets a rank in 1-3 arts (at least one guaranteed)
    arts_for_person = all_arts.sample(rand(1..3))
    arts_for_person.each do |art|
      Rank.create!(belt: art.belts.sample, person: person)
    end
  end
end

puts "Seeded:"
puts "  #{Art.count} arts"
puts "  #{Belt.count} belts"
puts "  #{Course.count} courses"
puts "  #{Family.count} families"
puts "  #{Person.count} people"
puts "  #{Rank.count} ranks"