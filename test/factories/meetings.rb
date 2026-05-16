FactoryBot.define do
  factory :meeting do
    association :course
    date { Date.today }
  end
end