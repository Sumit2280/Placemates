class Company < ApplicationRecord

  has_many :student_placements
  has_many :company_placements
  has_many :opportunities

  validates :name, :website, :information, presence: true

end
