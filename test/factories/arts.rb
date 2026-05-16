FactoryBot.define do
  factory :art do
    name   { Faker::Lorem.unique.word.capitalize }
    abbrev { name[0,3].upcase }   # e.g., "Karate" → "KAR"
  end
end