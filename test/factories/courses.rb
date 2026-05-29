FactoryBot.define do
  factory :course do
    day { Course.days.keys.sample }
    time { Faker::Time.between(from: Time.zone.parse("09:00"), to: Time.zone.parse("20:00")).strftime("%I:%M %p") }
    art
  end
end