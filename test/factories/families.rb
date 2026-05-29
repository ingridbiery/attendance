FactoryBot.define do
  factory :family do
    name { Faker::Name.unique.last_name }
  end
end