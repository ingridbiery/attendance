FactoryBot.define do
  factory :belt do
    name { Faker::Lorem.unique.word.capitalize }
    level  { Faker::Number.non_zero_digit.to_i }
    color { Faker::Color.color_name }
    art

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