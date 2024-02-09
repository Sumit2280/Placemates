class CompanyPlacement < ApplicationRecord
  belongs_to :company

  validates :year, presence: true
  validates :applied, :selected, presence: true
  
end
