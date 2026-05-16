FactoryBot.define do
  factory :course do
    day { %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday].sample }
    time { Time.zone.parse("18:00") }
    association :art
  end
end