FactoryBot.define do
  factory :attendance do
    meeting

    person do
      p = create(:person)

      unless p.belts.where(art_id: meeting.art_id).exists?
        Rank.create!(person: p, belt: meeting.art.belts.sample)
      end

      p
    end
  end
end