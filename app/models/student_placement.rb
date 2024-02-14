class StudentPlacement < ApplicationRecord
  belongs_to :user
  belongs_to :company

  validates :user_id, presence: true, uniqueness: true

end
