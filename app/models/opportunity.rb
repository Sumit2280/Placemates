class Opportunity < ApplicationRecord
  belongs_to :company

  has_many :user_applications
end
