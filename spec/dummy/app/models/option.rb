class Option < ApplicationRecord
  belongs_to :element

  validates :value, presence: true
end
