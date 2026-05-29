FactoryBot.define do
  factory :meeting do
    course
    art

    date do
      base = Faker::Date.backward(days: 60)
      target = Course.days[course.day]   # enum → integer 0–6
      delta = target - base.wday
      base + delta
    end
  end
end