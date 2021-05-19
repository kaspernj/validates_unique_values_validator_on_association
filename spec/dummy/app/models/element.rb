class Element < ApplicationRecord
  has_many :options, dependent: :destroy

  validates :options, unique_values_on_association: {attribute: :value}
end
