FactoryBot.define do
  factory :person do
    association :family

    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    dob        { Faker::Date.birthday(min_age: 5, max_age: 80) }
  end
end