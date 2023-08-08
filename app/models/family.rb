class Family < ApplicationRecord
  has_many :people, dependent: :destroy

  LEGAL_CHARS = /\A[a-zA-Z. \-\(\)\/']*\z/
  LEGAL_CHARS_MSG = "contains invalid characters. Valid characters: letters, space, period, dash, parentheses, slash."

  validates :name, presence: true,
  uniqueness: { case_sensitive: false },
  length: { maximum: 50 },
  format: { with: LEGAL_CHARS,
            message: LEGAL_CHARS_MSG}
end
