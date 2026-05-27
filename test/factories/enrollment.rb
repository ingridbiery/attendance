FactoryBot.define do
  factory :enrollment do
    association :person
    association :art
  end
end