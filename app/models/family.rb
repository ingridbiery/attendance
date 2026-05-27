class Family < ApplicationRecord
  has_many :people, dependent: :destroy

  LEGAL_CHARS = /\A[\p{L}\p{M} \-\.\/'\u2019]*\z/
  LEGAL_CHARS_MSG = "contains invalid characters. Valid characters: letters, space, apostrophe, period, dash, slash."

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { maximum: 50 },
                   format: { with: LEGAL_CHARS,
                             message: LEGAL_CHARS_MSG}
end
