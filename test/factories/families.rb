FactoryBot.define do
  factory :family do
    name { Faker::Name.unique.last_name.gsub(/[^0-9a-zA-Z. \-\(\)\/']/, '') }
  end
end