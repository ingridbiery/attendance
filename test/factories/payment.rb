FactoryBot.define do
  factory :payment do
    family
    art
    plan_type { Payment.plan_types.keys.sample }
    paid_until { Faker::Date.forward(days: 30) }
  end
end