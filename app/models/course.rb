class Course < ApplicationRecord
  belongs_to :art
  has_many :meetings
end
