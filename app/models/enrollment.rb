class Enrollment < ApplicationRecord
  belongs_to :person
  belongs_to :art

  validates :person_id, uniqueness: { scope: :art_id }
end