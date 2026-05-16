FactoryBot.define do
  factory :belt do
    level { Faker::Lorem.unique.word.capitalize }
    rank  { Faker::Number.non_zero_digit.to_i }
    color { Faker::Color.color_name }
    association :art

    # Default: no image
    img { nil }

    trait :with_good_image do
      img { "app/assets/images/test.png" }
    end

    trait :with_bad_image do
      img { "app/assets/images/#{Faker::Lorem.unique.word}.png" }
    end

  end
end