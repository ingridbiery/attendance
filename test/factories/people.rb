FactoryBot.define do
  factory :person do
    family
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    dob        { Faker::Date.birthday(min_age: 5, max_age: 80) }

    after(:create) do |person|
      arts = Art.includes(:belts).select { |a| a.belts.any? }
      next if arts.empty?

      arts.sample(rand(1..3)).each do |art|
        Rank.create!(person: person, belt: art.belts.sample)
      end
    end
  end
end